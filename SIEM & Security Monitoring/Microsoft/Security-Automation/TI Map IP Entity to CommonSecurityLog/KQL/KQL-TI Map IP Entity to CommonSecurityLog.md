```kql
let lookback = 1h;
let Alerts = materialize(
    AlertEvidence
    | where TimeGenerated > ago(lookback)
    | where Title has "TI Map IP Entity to CommonSecurityLog"
    | project 
        AlertTime = TimeGenerated, 
        AlertId, 
        Title, 
        SourceIP = RemoteIP
);
let AlertIPs = materialize(Alerts | distinct SourceIP);
let CSL = materialize(
    CommonSecurityLog
    | where TimeGenerated > ago(lookback)
    | where SourceIP in (AlertIPs)
    | project
        CSLTime = TimeGenerated,
        SourceIP,
        DeviceVendor,
        DeviceProduct,
        DeviceVersion,
        Activity,
        LogSeverity,
        DestinationIP,
        DestinationUserName,
        Message,
        EventOutcome,
        Reason,
        Computer,
        CollectorHostName
    | summarize arg_max(
        CSLTime,
        DeviceVendor,
        DeviceProduct,
        DeviceVersion,
        Activity,
        LogSeverity,
        DestinationIP,
        DestinationUserName,
        Message,
        EventOutcome,
        Reason,
        Computer,
        CollectorHostName
    ) by SourceIP
);
let TI = materialize(
    ThreatIntelIndicators
    | where TimeGenerated > ago(30d)
    | extend TI_Description = tostring(Data["description"])
    | extend TI_Type = tostring(Data["name"])
    | project 
        TI_Time = TimeGenerated,   
        ObservableValue, 
        Confidence, 
        TI_Description, 
        TI_Type
    | summarize arg_max(
        TI_Time, 
        Confidence, 
        TI_Description, 
        TI_Type
    ) by ObservableValue
);
Alerts
    | join kind=inner hint.strategy=broadcast (CSL) on SourceIP
    | join kind=inner hint.strategy=broadcast (TI) on $left.SourceIP == $right.ObservableValue
| summarize
    TimeGenerated = max(AlertTime),
    Title = any(Title),
    SourceIP = strcat_array(make_set(SourceIP,300), ", "),
    SourceIPCount = dcountif(SourceIP, isnotempty(SourceIP)),
    Confidence = any(Confidence),
    Description = any(TI_Description),
    Type = any(TI_Type),
    DeviceVendor = any(DeviceVendor),
    DeviceProduct = any(DeviceProduct),
    DeviceVersion = any(DeviceVersion),
    Activity = any(Activity),
    LogSeverity = any(LogSeverity),
    DestinationIP = any(DestinationIP),
    DestinationUserName = any(DestinationUserName),
    Message = any(Message),
    EventOutcome = any(EventOutcome),
    Reason = any(Reason),
    Computer = any(Computer),
    CollectorHostName = any(CollectorHostName)
by AlertId
| extend LocalTime = format_datetime(datetime_add("hour", 6, TimeGenerated), "dd-MM-yyyy HH:mm:ss.fff")
| order by TimeGenerated desc
```