```kql
let lookback = 1h;
let Alerts = materialize(
AlertEvidence
    | where TimeGenerated > ago(lookback)
    | where Title has "TI Map IP Entity to SigninLogs"
    | project 
        AlertTime = TimeGenerated, 
        AlertId, 
        Title, 
        SourceIP = RemoteIP,
        DisplayName=AdditionalFields.DisplayName,
        AccountUpn,
        AccountSid,
        MITRE_ATTACK_Technique= AttackTechniques
);
let AlertIPs = materialize(Alerts | distinct SourceIP);  
let SigninLogs = materialize(
SigninLogs
    | where TimeGenerated > ago(lookback)
    | where IPAddress in (AlertIPs)
    | project
         AlertTime=TimeGenerated,
         SourceSystem,
         OperationName,
         Login_Status=ResultSignature,
         Error_Message=ResultDescription,
         AppDisplayName,
         Authentication_Method= AuthenticationRequirement,
         SourceIP= IPAddress,
         City=LocationDetails.city,
         State=LocationDetails.state,
         Country=LocationDetails.countryOrRegion,
         Latitude=LocationDetails.geoCoordinates.latitude,
         Longitude=LocationDetails.geoCoordinates.longitude,
         Signin_status=Status,
         Error_Code=Status.errorCode,
         failureReason=Status.failureReason,
         UserPrincipalName,
         UserId,
         UserDisplayName
    | summarize arg_max(
        AlertTime,
        SourceSystem,
        OperationName,
        Login_Status,
        Error_Message,
        AppDisplayName,
        Authentication_Method,
        City,
        State,
        Country,
        Latitude,
        Longitude,
        Signin_status,
        UserPrincipalName,
        UserId,
        UserDisplayName,
        Error_Code,
        failureReason
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
    | join kind=inner hint.strategy=broadcast (SigninLogs) on SourceIP
    | join kind=inner hint.strategy=broadcast (TI) on $left.SourceIP == $right.ObservableValue
| summarize
        Title=any(Title),
        AlertTime=any(AlertTime),         
        SourceIP= strcat_array(make_set_if(SourceIP , isnotempty(SourceIP ), 300), ", "),
        SourceIPCount = dcountif(SourceIP, isnotempty(SourceIP)),
        Confidence=any(Confidence),
        DisplayName= any(DisplayName),
        AccountUpn=any(AccountUpn),
        AccountSid=any(AccountSid),
        MITRE_ATTACK_Technique=any(MITRE_ATTACK_Technique),       
        SourceSystem=any(SourceSystem),
        OperationName=any(OperationName),
        Login_Status=any(Login_Status),
        AppDisplayName=any(AppDisplayName),
        Authentication_Method=any(Authentication_Method),
        City=any(City),
        State=any(State),
        Country=any(Country),
        Latitude=any(Latitude),
        Longitude=any(Longitude),
        Error_Code=any(Error_Code),
        failureReason=any(failureReason),
        UserPrincipalName=any(UserPrincipalName),
        UserId=any(UserId),
        UserDisplayName=any(UserDisplayName)
    by AlertId
    | extend LocalTime = format_datetime(datetime_add("hour", 6, AlertTime), "dd-MM-yyyy HH:mm:ss.fff")
    | order by AlertTime desc
```