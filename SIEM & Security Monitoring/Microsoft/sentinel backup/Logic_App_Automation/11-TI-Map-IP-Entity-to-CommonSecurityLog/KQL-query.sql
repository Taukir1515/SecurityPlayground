let lookback = 24h;
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
        CSLTime_UTC = TimeGenerated,
        SourceIP,
        DeviceVendor,
        DeviceProduct,
        DeviceVersion,
        Activity= tostring(split(Activity, ":")[1]),
       // Activity= tostring(split(Activity,:,[1])),
        LogSeverity,
        DestinationIP,
        DestinationUserName,
        Message,
        EventOutcome,
        Reason,
        Computer,
        CollectorHostName
    | summarize arg_max(
        CSLTime_UTC,
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
    //| extend TI_Description = tostring(Data["description"])
    | extend TI_Type = tostring(Data["name"])
    | project 
        TI_Time = TimeGenerated,   
        ObservableValue, 
        Confidence, 
       // TI_Description, 
        TI_Type
    | summarize arg_max(
        TI_Time, 
        Confidence, 
      //  TI_Description, 
        TI_Type
    ) by ObservableValue
);
Alerts
    | join kind=inner hint.strategy=broadcast (CSL) on SourceIP
    | join kind=inner hint.strategy=broadcast (TI) on $left.SourceIP == $right.ObservableValue
| summarize
    TimeGenerated = max(AlertTime),
    Title = any(Title),
    SourceIP = make_set(SourceIP, 200),
    SourceIPCount = dcountif(SourceIP, isnotempty(SourceIP)),
    Confidence = max(Confidence),
   // Description = any(TI_Description),
    AlertReason = strcat_array(make_set(TI_Type,300), ", "),
  //  DeviceVendor = any(DeviceVendor),
    DeviceProduct = make_set(DeviceProduct,300),
    DeviceVersion = make_set(DeviceVersion,300),
    Activity = make_set(Activity,300),
    LogSeverity = max(LogSeverity),
    DestinationIP = make_set(DestinationIP,300),
    DestinationUserName = strcat_array(make_set(DestinationUserName,300), ", "),
    Message = strcat_array(make_set(Message,300), ", "),
    EventOutcome =strcat_array(make_set(EventOutcome,300), ", "),
    // Reason = any(Reason),
    Computer = strcat_array(make_set(Computer,300), ", "),
    CollectorHostName = strcat_array(make_set(CollectorHostName,300), ", ")
by DeviceVendor
| extend LocalTime = format_datetime(datetime_add("hour", 6, TimeGenerated), "dd-MM-yyyy HH:mm:ss.fff")
| extend
    SourceIPCount = array_length(SourceIP),
    SourceIP = strcat_array(SourceIP, ", ")
| order by TimeGenerated desc