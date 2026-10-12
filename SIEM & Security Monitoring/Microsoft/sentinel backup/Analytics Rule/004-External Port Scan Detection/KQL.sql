let isPrivateIP = (ip: string) {
    ip startswith "10."
    or ip startswith "::1"
    or ip startswith "fc00::"
    or ip startswith "fe80::"
    or ip startswith "192.168."
    or ip matches regex @"^172\.(1[6-9]|2[0-9]|3[0-1])\."
    or ip startswith "127."
    or ip startswith "169.254."
};
let normalizeIPv4 = (ip: string) {
    iff(ip startswith "::ffff:", substring(ip, 7), ip)
};
let lookback = 6h;
let PortThreshold = 100;
let Base = DeviceNetworkEvents
| where TimeGenerated > ago(lookback)
| where isnotempty(RemoteIP) and isnotempty(RemotePort)
| extend RemoteIP_norm = normalizeIPv4(RemoteIP)
| where not(isPrivateIP(RemoteIP_norm))
| extend
    AttackType = "External Port Scanning",
    LocalTime = format_datetime(datetime_add("hour", 6, TimeGenerated), "yyyy-MM-dd HH:mm:ss");
let RemoteIPCounts = Base
| summarize RemoteIPCount = dcount(RemoteIP_norm) by DeviceName;
let PerPort = Base
| summarize
    Remote_IP = make_set(RemoteIP_norm, 300),
    LastSeenPort = max(TimeGenerated)
  by DeviceName, RemotePort
| extend
    PortNum = toint(RemotePort),
    PortToIPs = strcat(tostring(RemotePort), " : ", Remote_IP);
PerPort
| where isnotnull(PortNum)
| sort by DeviceName asc, PortNum asc
| summarize
    TimeGenerated = max(LastSeenPort),
    LocalTime = format_datetime(datetime_add("hour", 6, max(LastSeenPort)), "yyyy-MM-dd HH:mm:ss"),
    RemotePortCount = dcount(RemotePort),
    AttackType = any("External Port Scanning"),
    Port_IP = make_list(PortToIPs),
    RemotePort= make_set(RemotePort)
  by DeviceName
| join kind=leftouter RemoteIPCounts on DeviceName
| where RemotePortCount >= PortThreshold