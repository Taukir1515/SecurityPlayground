```kql
let isPrivateIP = (ip: string) {
    ip startswith "10."
    or ip startswith "192.168."
    or ip matches regex @"^172\.(1[6-9]|2[0-9]|3[0-1])\."
    or ip startswith "127."
};
let lookback = 20m;
let PortThreshold = 20;
DeviceNetworkEvents
| where TimeGenerated > ago(lookback)       
| where isnotempty(RemoteIP)
| where not(isPrivateIP(RemoteIP))
| where isnotempty(RemotePort)
| extend
    RemoteIP_Type = "External IP",
    AttackType = "External Port Scanning",
    LocalTime = format_datetime(datetime_add("hour", 6, TimeGenerated), "yyyy-MM-dd HH:mm:ss.fff")
| summarize
    TimeGenerated = take_any(TimeGenerated),
    LocalTime = max(LocalTime),
    FirstSeen = min(TimeGenerated),
    LastSeen = max(TimeGenerated),
    ActionType = take_any(ActionType),
    DeviceId = take_any(DeviceId),
    RemoteIP= strcat_array(make_set_if(RemoteIP , isnotempty(RemoteIP ), 300), ", "),
    RemoteIPCount= dcount(RemoteIP),
    RemotePort= strcat_array(make_set_if(RemotePort , isnotempty(RemotePort ), 300), ", "),
    RemotePortCount = dcount(RemotePort),
    RemoteIP_Type = take_any(RemoteIP_Type),
    MachineGroup=any(MachineGroup),
    AttackType = take_any(AttackType)
by DeviceName
| where RemotePortCount >= PortThreshold    
```
