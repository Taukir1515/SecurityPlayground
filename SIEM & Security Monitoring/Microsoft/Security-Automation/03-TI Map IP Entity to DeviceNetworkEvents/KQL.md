```kql
let lookback = 1h;
let Alerts = materialize(
    AlertEvidence
    | where TimeGenerated > ago(lookback)
    | where Title has "TI Map IP Entity to DeviceNetworkEvents"
    | project 
        AlertTime = TimeGenerated, 
        AlertId, 
        Title, 
        SourceIP = RemoteIP
); 
let AlertIPs = materialize(Alerts | distinct SourceIP);  
let DNE = materialize(
DeviceNetworkEvents
    | where TimeGenerated > ago(lookback)
    | project
        DNETime = TimeGenerated,
        ActionType,
        SourceIP=RemoteIP,
        RemoteIPType,
        RemotePort,
        RemoteUrl,
        DeviceName,
        DeviceId,
        InitiatingProcessAccountDomain,
        InitiatingProcessAccountName,
        InitiatingProcessAccountSid,
        InitiatingProcessAccountUpn,
        InitiatingProcessFileName,
        InitiatingProcessFolderPath,
        InitiatingProcessMD5,
        InitiatingProcessFileSize,
        LocalIP,
        LocalIPType,
        LocalPort,
        MachineGroup
    | summarize arg_max(
        DNETime,
        ActionType,
        RemoteIPType,
        RemotePort,
        RemoteUrl,
        DeviceName,
        DeviceId,
        InitiatingProcessAccountDomain,
        InitiatingProcessAccountName,
        InitiatingProcessAccountSid,
        InitiatingProcessAccountUpn,
        InitiatingProcessFileName,
        InitiatingProcessFolderPath,
        InitiatingProcessMD5,
        InitiatingProcessFileSize,
        LocalIP,
        LocalIPType,
        LocalPort,
        MachineGroup
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
    | join kind=inner hint.strategy=broadcast (DNE) on SourceIP
    | join kind=inner hint.strategy=broadcast (TI) on $left.SourceIP == $right.ObservableValue
| summarize
    TimeGenerated = max(AlertTime),
    Title = any(Title),
    SourceIP = strcat_array(make_set_if(SourceIP , isnotempty(SourceIP ), 300), ", "),
    SourceIPCount = dcountif(SourceIP, isnotempty(SourceIP)),
    Confidence = any(Confidence),
    RemoteIPType=any(RemoteIPType),
    RemotePort= strcat_array(make_set(RemotePort,300), ", "),
    RemotePortCount = dcountif(RemotePort, isnotempty(RemotePort)),
    RemoteUrl= strcat_array(make_set(RemoteUrl,300), ", "),
    Description = any(TI_Description),
    Type = any(TI_Type),
    ActionType= any(ActionType),
    DeviceName= strcat_array(make_set(DeviceName,300), ", "),
    DeviceId= strcat_array(make_set(DeviceId,300), ", "),
    InitiatingProcessAccountDomain = strcat_array(make_set_if(InitiatingProcessAccountDomain, isnotempty(InitiatingProcessAccountDomain), 300), ", "),
    InitiatingProcessAccountName= strcat_array(make_set_if(InitiatingProcessAccountName, isnotempty(InitiatingProcessAccountName), 300), ", "),
    InitiatingProcessAccountSid= strcat_array(make_set_if(InitiatingProcessAccountSid, isnotempty(InitiatingProcessAccountSid), 300), ", "),
    InitiatingProcessAccountUpn= strcat_array(make_set_if(InitiatingProcessAccountUpn, isnotempty(InitiatingProcessAccountUpn), 300), ", "),
    InitiatingProcessFileName= strcat_array(make_set_if(InitiatingProcessFileName, isnotempty(InitiatingProcessFileName), 300), ", "),
    InitiatingProcessFolderPath= strcat_array(make_set_if(InitiatingProcessFolderPath, isnotempty(InitiatingProcessFolderPath), 300), ", "),
    InitiatingProcessMD5= strcat_array(make_set_if(InitiatingProcessMD5, isnotempty(InitiatingProcessMD5), 300), ", "),
    InitiatingProcessFileSize= strcat_array(make_set_if(InitiatingProcessFileSize, isnotempty(InitiatingProcessFileSize), 300), ", "),
    LocalIP= strcat_array(make_set(LocalIP,300), ", "),
    LocalIPType=any(LocalIPType),
    LocalPort= strcat_array(make_set(LocalPort,300), ", "),
    MachineGroup= strcat_array(make_set(MachineGroup,300), ", ")
by AlertId
    | extend LocalTime = format_datetime(datetime_add("hour", 6, TimeGenerated), "dd-MM-yyyy HH:mm:ss.fff")
    | order by TimeGenerated desc
```