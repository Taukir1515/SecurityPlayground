let IPRegex = '[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}';
let dt_lookBack = 24h; 
let ioc_lookBack = 14d; 
let IP_Indicators = ThreatIntelIndicators
     | extend IndicatorType = replace(@"\[|\]|\""", "", tostring(split(ObservableKey, ":", 0)))
     | where IndicatorType in ("ipv4-addr", "ipv6-addr", "network-traffic")
     | extend NetworkSourceIP = toupper(ObservableValue)
     | extend TrafficLightProtocolLevel = tostring(parse_json(AdditionalFields).TLPLevel)
  | where TimeGenerated >= ago(ioc_lookBack)
  | extend TI_ipEntity = iff(isnotempty(NetworkSourceIP), NetworkSourceIP, NetworkSourceIP)
  | extend TI_ipEntity = iff(isempty(TI_ipEntity) and isnotempty(NetworkSourceIP), NetworkSourceIP, TI_ipEntity)
  | where ipv4_is_private(TI_ipEntity) == false and  TI_ipEntity !startswith "fe80" and TI_ipEntity !startswith "::" and TI_ipEntity !startswith "127."
  | summarize LatestIndicatorTime = arg_max(TimeGenerated, *) by Id, ObservableValue
  | where IsActive and (ValidUntil > now() or isempty(ValidUntil));
IP_Indicators
   | project-reorder *, Tags, TrafficLightProtocolLevel, NetworkSourceIP, Type, TI_ipEntity
  | join kind=innerunique (
      CommonSecurityLog
      | where TimeGenerated >= ago(dt_lookBack)
      | extend MessageIP = extract(IPRegex, 0, Message)
      | extend CS_ipEntity = iff((not(ipv4_is_private(SourceIP)) and isnotempty(SourceIP)), SourceIP, DestinationIP)
      | extend CS_ipEntity = iff(isempty(CS_ipEntity) and isnotempty(MessageIP), MessageIP, CS_ipEntity)
      | extend CommonSecurityLog_TimeGenerated = TimeGenerated
  )
  on $left.TI_ipEntity == $right.CS_ipEntity
  | where CommonSecurityLog_TimeGenerated < ValidUntil
  | summarize CommonSecurityLog_TimeGenerated = arg_max(CommonSecurityLog_TimeGenerated, *) by Id, CS_ipEntity
  | project timestamp = CommonSecurityLog_TimeGenerated, SourceIP, DestinationIP, MessageIP, Message, DeviceVendor, DeviceProduct, Id, ValidUntil, Confidence, TI_ipEntity, CS_ipEntity, LogSeverity, DeviceAction, Type
