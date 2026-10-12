// Cisco Firewall – RDP Brute Force Attempt from Known Malicious Source IP
let DeviceMap =
DeviceNetworkEvents
| where isnotempty(LocalIP)
| summarize 
        arg_max(
            TimeGenerated, 
            DeviceName
            ) 
    by LocalIP;
let TI = materialize(
ThreatIntelIndicators
| where TimeGenerated > ago(30d)
| project 
    TI_Time=TimeGenerated,
    ObservableValue,
    Confidence
| summarize 
    arg_max(
    TI_Time,
    Confidence
    ) 
    by ObservableValue
);
let GeoMap =
SigninLogs
| where TimeGenerated > ago(30d)
| where isnotempty(IPAddress)
| extend GeoData=todynamic(LocationDetails)
| extend Country=tostring(GeoData.countryOrRegion),
        City=tostring(GeoData.city),
        State=tostring(GeoData.state)
| summarize 
        arg_max(
        TimeGenerated,
        Country,
        City,
        State
        ) 
    by IPAddress;
Syslog
| where TimeGenerated > ago(1d)
| where SyslogMessage has "dport=3389"
| extend src=extract("src=([0-9\\.]+)",1,SyslogMessage)
| extend dst=extract("dst=([0-9\\.]+)",1,SyslogMessage)
| extend action=case(SyslogMessage has "pattern: 1","Deny",
        SyslogMessage has "pattern: 0","Allow","Unknown")
| where isnotempty(src) and isnotempty(dst)
| where not(src startswith "10.") and not(src startswith "192.168.") and not(src matches regex @"^172\.(1[6-9]|2[0-9]|3[0-1])\.")
| summarize ConnectionCount=count(),
        DenyCount=countif(action=="Deny"),
        AllowCount=countif(action=="Allow"),
        FirstSeen=min(TimeGenerated),
        LastSeen=max(TimeGenerated),
        Computer=any(Computer),
        SyslogMessage=any(SyslogMessage) 
        by src,dst
| join kind=leftouter hint.strategy=broadcast (DeviceMap) on $left.Computer==$right.LocalIP
| join kind=inner hint.strategy=broadcast (TI) on $left.src==$right.ObservableValue
| join kind=leftouter hint.strategy=broadcast (GeoMap) on $left.src==$right.IPAddress
| where ConnectionCount >= 50  //Threshold
| extend LocationStatus=iff(isnotempty(Country) or isnotempty(City),"Found in SigninLogs","No SigninLogs  ")
| extend FirstSeen_Dhaka=format_datetime(FirstSeen + 6h,"yyyy-MM-dd hh:mm:ss tt"),LastSeen_Dhaka=format_datetime(LastSeen + 6h,"yyyy-MM-dd hh:mm:ss tt")
| project 
    Suspicious_Source_IP=src,
    Country,
    City,
    State,
    LocationStatus,
    ThreatConfidence=Confidence,
    DestinationIP=dst,
    DeviceName,
    DestinationLocalIP=Computer,
    ConnectionCount,
    DenyCount,
    AllowCount,
    FirstSeen_Dhaka,
    LastSeen_Dhaka
| order by DenyCount desc,ConnectionCount desc