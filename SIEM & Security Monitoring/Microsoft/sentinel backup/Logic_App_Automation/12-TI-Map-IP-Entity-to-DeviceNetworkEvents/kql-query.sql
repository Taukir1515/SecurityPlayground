let lookback = 24h;
let Alerts = materialize(
    AlertEvidence
    | where TimeGenerated > ago(lookback)
    | where Title has "TI Map IP Entity to DeviceNetworkEvents"
    | where isnotempty(RemoteIP)
    | project 
        AlertTime = TimeGenerated, 
        AlertId, 
        Title, 
        RemoteIP
); 
let AlertIPs = materialize(Alerts | distinct RemoteIP);  
let DNE = materialize(
DeviceNetworkEvents
    | where TimeGenerated > ago(lookback)
    | extend InitiatingProcessFileSize_MB = round(InitiatingProcessFileSize / 1024.0 / 1024.0, 2)
    | project
        DNETime = TimeGenerated,
        ActionType,
        RemoteIP,
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
        InitiatingProcessFileSize_MB,
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
        InitiatingProcessFileSize_MB,
        LocalIP,
        LocalIPType,
        LocalPort,
        MachineGroup
    ) by RemoteIP
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
    | join kind=inner hint.strategy=broadcast (DNE) on RemoteIP
    | join kind=inner hint.strategy=broadcast (TI) on $left.RemoteIP == $right.ObservableValue
| summarize
    TimeGenerated = max(AlertTime),
    Title = any(Title),
    RemoteIP = strcat_array(make_set_if(RemoteIP , isnotempty(RemoteIP), 300), ", "),
    RemoteIPCount = dcountif(RemoteIP, isnotempty(RemoteIP)),
    Confidence = max(Confidence),
   // RemoteIPType=any(RemoteIPType),
    RemotePort= strcat_array(make_set(RemotePort,300), ", "),
    RemotePortCount = dcountif(RemotePort, isnotempty(RemotePort)),
    RemoteUrl= strcat_array(make_set(RemoteUrl,300), ", "),
    // Description = any(TI_Description),
    AlertReason = strcat_array(make_set(TI_Type,300), ", "),
    ActionType= any(ActionType),
    DeviceName= strcat_array(make_set(DeviceName,300), ", "),
    //DeviceId= strcat_array(make_set(DeviceId,300), ", "),
    InitiatingProcessAccountDomain = strcat_array(make_set_if(InitiatingProcessAccountDomain, isnotempty(InitiatingProcessAccountDomain), 300), ", "),
    InitiatingProcessAccountName= strcat_array(make_set_if(InitiatingProcessAccountName, isnotempty(InitiatingProcessAccountName), 300), ", "),
    InitiatingProcessAccountSid= strcat_array(make_set_if(InitiatingProcessAccountSid, isnotempty(InitiatingProcessAccountSid), 300), ", "),
    InitiatingProcessAccountUpn= strcat_array(make_set_if(InitiatingProcessAccountUpn, isnotempty(InitiatingProcessAccountUpn), 300), ", "),
    InitiatingProcessFileName= strcat_array(make_set_if(InitiatingProcessFileName, isnotempty(InitiatingProcessFileName), 300), ", "),
    InitiatingProcessFolderPath= strcat_array(make_set_if(InitiatingProcessFolderPath, isnotempty(InitiatingProcessFolderPath), 300), ", "),
    InitiatingProcessMD5= strcat_array(make_set_if(InitiatingProcessMD5, isnotempty(InitiatingProcessMD5), 300), ", "),
    InitiatingProcessFileSize_MB= strcat_array(make_set_if(InitiatingProcessFileSize_MB, isnotempty(InitiatingProcessFileSize_MB), 300), ", "),
    LocalIP= strcat_array(make_set(LocalIP,300), ", "),
    //LocalIPType=any(LocalIPType),
    LocalPort= strcat_array(make_set(LocalPort,300), ", ")
  //  MachineGroup= strcat_array(make_set(MachineGroup,300), ", ")
by MachineGroup
    | extend LocalTime = format_datetime(datetime_add("hour", 6, TimeGenerated), "dd-MM-yyyy HH:mm:ss.fff")
    | order by TimeGenerated desc