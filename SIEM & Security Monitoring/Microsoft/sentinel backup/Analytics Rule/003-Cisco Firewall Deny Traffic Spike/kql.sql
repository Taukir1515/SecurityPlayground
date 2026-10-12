let KnownDenyActivity =
Syslog
| where TimeGenerated between (ago(14d) .. ago(1d))
| where SyslogMessage contains "deny"
| extend src = extract("src=([0-9\\.]+)", 1, SyslogMessage)
| where isnotempty(src)
| summarize AvgDenyCount=count() by src;
let DestinationDomainMap =
DeviceNetworkEvents
| where TimeGenerated > ago(7d)
| where isnotempty(RemoteIP)
| where isnotempty(RemoteUrl)
| summarize arg_max(TimeGenerated, RemoteUrl) by RemoteIP
| project DestinationIP=RemoteIP, Domain=tostring(RemoteUrl);
let RecentDeny =
Syslog
| where TimeGenerated > ago(1d)
| where SyslogMessage contains "deny"
| extend src = extract("src=([0-9\\.]+)", 1, SyslogMessage)
| extend dst = extract("dst=([0-9\\.]+)", 1, SyslogMessage)
| extend dport = extract("dport=(\\d+)", 1, SyslogMessage)
| where isnotempty(src)
| summarize 
    DenyCount=count(),
    DistinctDst=dcount(dst),
    DstList=make_set(dst,50),
    Ports=make_set(dport,20)
    by src, TimeBin=bin(TimeGenerated,5m);
let DeviceMap =
DeviceNetworkEvents
| where TimeGenerated > ago(7d)
| where isnotempty(LocalIP)
| summarize arg_max(
    TimeGenerated,
    DeviceName,
    InitiatingProcessAccountUpn,
    InitiatingProcessAccountDomain,
    InitiatingProcessAccountName
) by LocalIP
| extend DeviceAccount = iff(
    isnotempty(InitiatingProcessAccountUpn),
    InitiatingProcessAccountUpn,
    strcat(InitiatingProcessAccountDomain, "\\", InitiatingProcessAccountName)
)
| project 
    LocalIP, 
    DeviceName, 
    DeviceAccount;
let SigninEvidence =
SigninLogs
| where TimeGenerated > ago(1d)
| where isnotempty(IPAddress)
| project 
    SigninIP=IPAddress,
    SigninTime=TimeGenerated,
    SigninUser=UserPrincipalName;
let Suspicious =
RecentDeny
| join kind=leftouter KnownDenyActivity on src
| extend AvgDenyCount = iff(isnull(AvgDenyCount), 0, AvgDenyCount)
| where DenyCount > 100 or DenyCount > (AvgDenyCount * 5)
| join kind=leftouter DeviceMap on $left.src == $right.LocalIP
| join kind=leftouter SigninEvidence on $left.src == $right.SigninIP
| where isnull(SigninTime) or SigninTime <= TimeBin
| extend MinutesBetween = iff(
    isnotnull(SigninTime),
    datetime_diff("minute", TimeBin, SigninTime),
    int(null)
)
| extend MatchSort = iff(isnull(MinutesBetween), 999999, MinutesBetween)
| summarize arg_min(MatchSort, *) 
    by src, TimeBin, DenyCount, DistinctDst
| extend Account = case(
    isnotempty(SigninUser), SigninUser,
    isnotempty(DeviceAccount), DeviceAccount,
    ""
)
| extend TimeMatchStrength = case(
    isnull(MinutesBetween), "",
    MinutesBetween <= 60, "Strong",
    MinutesBetween <= 120, "Moderate",
    MinutesBetween <= 180, "Weak",
    "OutOfRange"
)
| extend PortCount = array_length(Ports)
| extend ReasonList = pack_array(
    iff(DenyCount > 100, "High denied connection volume", ""),
    iff(DenyCount > (AvgDenyCount * 5), "Deviation from baseline", ""),
    iff(DistinctDst >= 10, "Scanning multiple targets", ""),
    iff(PortCount >= 5, "Multiple ports targeted", "")
);
let FinalMetrics =
Suspicious
| summarize 
    FirstSeen=min(TimeBin),
    LastSeen=max(TimeBin),
    PeakDeny=max(DenyCount),
    TotalDeny=sum(DenyCount),
    MaxDistinctDst=max(DistinctDst),
    MaxPortCount=max(PortCount),
    MinMinutesBetween=min(MinutesBetween),
    BestTimeMatch=arg_min(MatchSort, TimeMatchStrength)
    by src, DeviceName, Account;
let FinalDestinations =
Suspicious
| mv-expand Destination=DstList to typeof(string)
| where isnotempty(Destination)
| join kind=leftouter DestinationDomainMap on $left.Destination == $right.DestinationIP
| extend ResolvedDestination = iff(
    isnotempty(Domain),
    strcat(Destination, " : ", Domain),
    Destination
)
| summarize Destinations=make_set(ResolvedDestination,50)
    by src, DeviceName, Account;
let FinalPorts =
Suspicious
| mv-expand Port=Ports to typeof(string)
| where isnotempty(Port)
| summarize Ports=make_set(Port,20)
    by src, DeviceName, Account;
let FinalReasons =
Suspicious
| mv-expand ReasonItem=ReasonList to typeof(string)
| where isnotempty(ReasonItem)
| summarize Reason=make_set(ReasonItem,20)
    by src, DeviceName, Account;
FinalMetrics
| join kind=leftouter FinalDestinations on src, DeviceName, Account
| join kind=leftouter FinalPorts on src, DeviceName, Account
| join kind=leftouter FinalReasons on src, DeviceName, Account
| extend RawRiskScore =
      iif(PeakDeny >= 500, 30, iif(PeakDeny >= 300, 20, 10))
    + iif(MaxDistinctDst >= 50, 25, iif(MaxDistinctDst >= 20, 15, 5))
    + iif(MaxPortCount >= 10, 20, iif(MaxPortCount >= 5, 10, 5))
| extend RiskScore = iff(RawRiskScore > 100, 100, RawRiskScore)
| extend RiskLevel = case(
    RiskScore >= 90, "Critical",
    RiskScore >= 70, "High",
    RiskScore >= 40, "Medium",
    "Low"
)
| extend
    FirstSeen_Dhaka = format_datetime(FirstSeen + 6h, "yyyy-MM-dd hh:mm:ss tt"),
    LastSeen_Dhaka = format_datetime(LastSeen + 6h, "yyyy-MM-dd hh:mm:ss tt")
| project 
    FirstSeen_Dhaka,
    LastSeen_Dhaka,
    src,
    DeviceName,
    Account,
    TotalDeny,
    PeakDeny,
    MaxDistinctDst,
    MaxPortCount,
    Destinations,
    Ports,
    RiskScore,
    RiskLevel,
    Reason
    //MinMinutesBetween
    //BestTimeMatch
| order by PeakDeny desc, TotalDeny desc
| take 5