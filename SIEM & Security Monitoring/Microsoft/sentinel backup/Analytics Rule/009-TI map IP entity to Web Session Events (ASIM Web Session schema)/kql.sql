let HAS_ANY_MAX = 10000;
let dt_lookBack = 2h;
let ioc_lookBack = 14d;
let IP_TI = ThreatIntelIndicators
//extract key part of kv pair
     | extend IndicatorType = replace(@"\[|\]|\""", "", tostring(split(ObservableKey, ":", 0)))
     | where IndicatorType in ("ipv4-addr", "ipv6-addr", "network-traffic")
     | extend NetworkSourceIP = toupper(ObservableValue)
     | extend TrafficLightProtocolLevel = tostring(parse_json(AdditionalFields).TLPLevel)
  | where TimeGenerated >= ago(ioc_lookBack)
  // As there is potentially more than 1 indicator type for matching IP, taking NetworkIP first, then others if that is empty.
  // Taking the first non-empty value based on potential IOC match availability
  | extend TI_ipEntity = NetworkSourceIP
  // Picking up only IOC's that contain the entities we want
  | where TI_ipEntity != "NO_IP"
  // Exclude local addresses, using the ipv4_is_private operator
  | where ipv4_is_private(TI_ipEntity) == false and TI_ipEntity !startswith "fe80" and TI_ipEntity !startswith "::" and TI_ipEntity !startswith "127."
  | extend ThreatType = tostring(Data.indicator_types[0])
  | extend IndicatorId = tostring(split(Id, "--")[2])
  | summarize LatestIndicatorTime = arg_max(TimeGenerated, *) by IndicatorId, ObservableValue
  | where IsActive and (ValidUntil > now() or isempty(ValidUntil));
let IP_TI_list = toscalar(IP_TI
  | summarize NIoCs = dcount(TI_ipEntity), IoCs = make_set(TI_ipEntity)
  | project IoCs = iff(NIoCs > HAS_ANY_MAX, dynamic([]), IoCs));
IP_TI
   | project-reorder *, Tags, TrafficLightProtocolLevel, NetworkSourceIP, Type, TI_ipEntity
// using innerunique to keep perf fast and result set low, we only need one match to indicate potential malicious activity that needs to be investigated
| join kind = innerunique (
    _Im_WebSession (starttime = ago(dt_lookBack), srcipaddr_has_any_prefix = IP_TI_list)
    | where isnotempty(SrcIpAddr)
    // renaming time column so it is clear the log this came from
    | extend imNWS_TimeGenerated = TimeGenerated
  )
  on $left.TI_ipEntity == $right.SrcIpAddr
| where imNWS_TimeGenerated < ValidUntil
| summarize imNWS_TimeGenerated = arg_max(imNWS_TimeGenerated, *) by IndicatorId, DstIpAddr
| extend Description = tostring(parse_json(Data).description)
| extend ActivityGroupNames = extract(@"ActivityGroup:(\S+)", 1, tostring(parse_json(Data).labels))
| project imNWS_TimeGenerated, Description, ActivityGroupNames, IndicatorId, ThreatType, ValidUntil, Confidence, TI_ipEntity, Dvc, SrcIpAddr, DstIpAddr, Url
