```kql
let lookback = 1h;
let Alerts = materialize(
    AlertEvidence
    | where TimeGenerated > ago(lookback)
    | where Title contains "web request matches an IP IoC"
    | extend MatchedIP = extract(@"The IP\s+((?:[0-9]{1,3}\.){3}[0-9]{1,3})", 1, Title)
    | where isnotempty(MatchedIP) and isnotnull(parse_ipv4(MatchedIP))
    | project 
        AlertTime = TimeGenerated,
        AlertId,
        Title,
        SourceIP = MatchedIP,
        MITRE_ATTACK_Techniques= AttackTechniques
);
let TI = materialize(
    ThreatIntelIndicators
    | where TimeGenerated > ago(10d)
    | extend TI_Description = tostring(Data["description"])
    | extend TI_Type        = tostring(Data["name"])
    | project 
        TI_Time = TimeGenerated,
        ObservableValue,
        Confidence,
        TI_Description,
        TI_Type
    | summarize arg_max(TI_Time, Confidence, TI_Description, TI_Type) by ObservableValue
);
Alerts
| join kind=inner hint.strategy=broadcast (TI) on $left.SourceIP == $right.ObservableValue
| summarize
    AlertTime      = max(AlertTime),
    Title          = any(Title),
    SourceIP       = any(SourceIP),
    Confidence     = max(Confidence),
    TI_Description = any(TI_Description),
    TI_Type        = any(TI_Type)
  by AlertId
| extend LocalTime = format_datetime(datetime_add("hour", 6, AlertTime), "dd-MM-yyyy HH:mm:ss.fff")
| order by AlertTime desc
```
