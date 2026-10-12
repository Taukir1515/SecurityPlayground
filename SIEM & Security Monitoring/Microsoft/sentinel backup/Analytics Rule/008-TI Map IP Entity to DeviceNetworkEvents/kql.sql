let dt_lookBack = 24h;
let ioc_lookBack = 14d;
let DeviceNetworkEvents_ = DeviceNetworkEvents
| where isnotempty(RemoteIP)
| where TimeGenerated > ago(dt_lookBack)
| where ActionType !has "ConnectionFailed"
| extend isPrivate = ipv4_is_private(RemoteIP)
| where isPrivate != true;
let IPs = DeviceNetworkEvents_ | distinct RemoteIP | summarize make_list(RemoteIP);
ThreatIntelIndicators
//extract key part of kv pair
     | extend IndicatorType = replace(@"\[|\]|\""", "", tostring(split(ObservableKey, ":", 0)))
     | where IndicatorType in ("ipv4-addr", "ipv6-addr", "network-traffic")
     | extend NetworkSourceIP = toupper(ObservableValue)
     | extend TrafficLightProtocolLevel = tostring(parse_json(AdditionalFields).TLPLevel)
| where TimeGenerated >= ago(ioc_lookBack)
| extend TI_ipEntity = NetworkSourceIP
| where TI_ipEntity in (IPs)
| summarize LatestIndicatorTime = arg_max(TimeGenerated, *) by Id, ObservableValue
| where IsActive and (ValidUntil > now() or isempty(ValidUntil))
| extend Description = tostring(parse_json(Data).description)
| where Description !contains_cs "State: inactive;" and Description !contains_cs "State: falsepos;"
| join kind=innerunique (DeviceNetworkEvents_) on $left.TI_ipEntity == $right.RemoteIP
| summarize TimeGenerated = arg_max(TimeGenerated, *) by Id, TI_ipEntity, DeviceName
| extend timestamp = TimeGenerated, Name = tostring(split(InitiatingProcessAccountUpn, '@', 0)[0]), UPNSuffix = tostring(split(InitiatingProcessAccountUpn, '@', 1)[0])
| project-reorder *, Tags, TrafficLightProtocolLevel, NetworkSourceIP, Type, TI_ipEntity
