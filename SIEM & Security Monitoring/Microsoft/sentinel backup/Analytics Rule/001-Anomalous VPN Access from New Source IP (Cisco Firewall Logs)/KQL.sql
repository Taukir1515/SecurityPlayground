let KnownIPs =
Syslog
| where TimeGenerated between (ago(14d) .. ago(1d))
| where SyslogMessage contains "vpn_firewall"
| extend src = extract("src=([0-9\\.]+)", 1, SyslogMessage)
| where isnotempty(src)
| distinct src;
let SuspiciousSyslog =
Syslog
| where TimeGenerated > ago(1d)
| where SyslogMessage contains "vpn_firewall"
| extend src = extract("src=([0-9\\.]+)", 1, SyslogMessage)
| extend dst = extract("dst=([0-9\\.]+)", 1, SyslogMessage)
| extend dport = extract("dport=(\\d+)", 1, SyslogMessage)
| where isnotempty(src)
| summarize 
    ConnectionCount=count(), 
    DistinctDst=dcount(dst), 
    DstList=make_set(dst,50), 
    Ports=make_set(dport,50) 
    by src, SyslogTime=bin(TimeGenerated,5m)
| where src !in (KnownIPs)
| where ConnectionCount > 100 or DistinctDst > 20 or array_length(Ports) > 5
| extend Ports_str=strcat_array(Ports,", "), 
        PortCount=array_length(Ports), 
        UncommonPortCount=array_length(set_difference(Ports,dynamic(["22","53","80","88","123","135","389","443","445","515","3389"])));
let DeviceMap =
DeviceNetworkEvents
| where isnotempty(LocalIP)
| summarize arg_max(TimeGenerated, DeviceId, DeviceName) 
by LocalIP
| project LocalIP, DeviceId, DeviceName;
let UserEvidence =
DeviceLogonEvents
| where ActionType == "LogonSuccess"
| where LogonType == "Interactive"
| where AccountName !startswith "dwm-"
| where AccountName !startswith "umfd-"
| project DeviceId, LogonTime=TimeGenerated, AccountName, AccountDomain, LogonType;
let Correlated =
SuspiciousSyslog
| join kind=leftouter DeviceMap on $left.src == $right.LocalIP
| join kind=leftouter UserEvidence on DeviceId
| where isempty(LogonTime) or LogonTime <= SyslogTime
| extend MinutesBetween=iff(isnotempty(LogonTime), 
        datetime_diff("minute", 
        SyslogTime, LogonTime), int(null))
| summarize arg_min(MinutesBetween, *) 
    by src, SyslogTime, DeviceName, ConnectionCount, DistinctDst, PortCount, UncommonPortCount
| extend Account=iff(isnotempty(AccountName), 
        strcat(AccountDomain, "\\", 
        AccountName), "")
| extend TimeMatchStrength=case(isnull(MinutesBetween), 
        "No user match", 
        MinutesBetween <= 60, "Strong", 
        MinutesBetween <= 120, "Moderate", 
        MinutesBetween <= 180, "Weak", 
        "OutOfRange")
| extend RawRiskScore=
      iif(ConnectionCount >= 250, 25, iif(ConnectionCount >= 180, 20, iif(ConnectionCount >= 120, 15, 5)))
    + iif(DistinctDst >= 10, 20, iif(DistinctDst >= 3, 12, 4))
    + iif(Ports_str has "445", 15, 0)
    + iif(Ports_str has "3389", 10, 0)
    + iif(Ports_str has "135", 5, 0)
    + iif(Ports_str has "22", 5, 0)
    + iif(Ports_str has "22" and DistinctDst >= 3, 10, 0)
    + iif(Ports_str has "22" and ConnectionCount >= 100, 10, 0)
    + iif(Ports_str has "53" and ConnectionCount >= 150 and DistinctDst == 1, 10, 0)
    + iif(PortCount >= 10, 20, iif(PortCount >= 6, 12, iif(PortCount >= 3, 5, 0)))
    + iif(UncommonPortCount >= 5, 15, iif(UncommonPortCount >= 3, 8, iif(UncommonPortCount >= 1, 3, 0)))
    + iif(isempty(DeviceName), 5, 0)
    + iif(isempty(Account), 5, 0)
| extend RiskScore=iff(RawRiskScore > 100, 100, RawRiskScore)
| extend ReasonList=pack_array(
    iff(ConnectionCount >= 180, "High connection volume", ""),
    iff(DistinctDst >= 3, "Multiple destinations", ""),
    iff(Ports_str has "445", "SMB traffic", ""),
    iff(Ports_str has "3389", "RDP traffic", ""),
    iff(Ports_str has "135", "RPC traffic", ""),
    iff(Ports_str has "22", "SSH traffic", ""),
    iff(Ports_str has "22" and DistinctDst >= 3, "SSH to multiple hosts", ""),
    iff(Ports_str has "22" and ConnectionCount >= 100, "High-volume SSH activity", ""),
    iff(Ports_str has "53" and ConnectionCount >= 150 and DistinctDst == 1, "DNS-heavy single-target activity", ""),
    iff(PortCount >= 6, "Multiple distinct ports", ""),
    iff(UncommonPortCount >= 3, "Several uncommon ports", "")
)
| project 
    SyslogTime, 
    src, 
    DeviceName, 
    Account, 
    ConnectionCount, 
    DistinctDst, 
    DstList, 
    Ports, 
    PortCount, 
    UncommonPortCount, 
    RiskScore, 
    ReasonList, 
    MinutesBetween, 
    TimeMatchStrength;
Correlated
| mv-expand Port=Ports to typeof(string)
| mv-expand Destination=DstList to typeof(string)
| mv-expand ReasonItem=ReasonList to typeof(string)
| where isnotempty(ReasonItem)
| summarize 
    FirstSeen=min(SyslogTime), 
    LastSeen=max(SyslogTime), 
    PeakRiskScore=max(RiskScore), 
    PeakConnectionCount=max(ConnectionCount), 
    TotalConnections=sum(ConnectionCount), 
    MaxDistinctDst=max(DistinctDst), 
    MaxPortCount=max(PortCount), 
    MaxUncommonPortCount=max(UncommonPortCount), 
    Ports=make_set(Port,10), 
    Destinations=make_set(Destination,20), 
    Reason=make_set(ReasonItem,20), 
    MinMinutesBetween=min(MinutesBetween), 
    BestTimeMatch=arg_min(MinutesBetween, 
    TimeMatchStrength) 
    by src, DeviceName, Account
| extend RiskLevel=case(PeakRiskScore >= 90, 
    "Critical", PeakRiskScore >= 70, 
    "High", PeakRiskScore >= 40, 
    "Medium", "Low")
| order by PeakRiskScore desc, TotalConnections desc
| take 5
| extend
    FirstSeen_Dhaka = format_datetime(FirstSeen + 6h, "yyyy-MM-dd hh:mm:ss tt"),
    LastSeen_Dhaka  = format_datetime(LastSeen + 6h, "yyyy-MM-dd hh:mm:ss tt")
| project 
    FirstSeen_Dhaka, 
    LastSeen_Dhaka, 
    PeakRiskScore, 
    RiskLevel, 
    src, 
    DeviceName, 
    Account, 
    PeakConnectionCount, 
    TotalConnections, 
    MaxDistinctDst, 
    MaxPortCount, 
    MaxUncommonPortCount, 
    Destinations, 
    Ports, 
    Reason, 
    MinMinutesBetween, 
    BestTimeMatch