```kql
AlertInfo
| where Title has "WinActivator"
| where TimeGenerated > ago(30m)
| extend ProtectionStatus = iff(Title has "prevented", "Prevented", "Detected")
| join kind=leftouter AlertEvidence on AlertId
| summarize
    ImpactedAsset = coalesce(
        anyif(DeviceName, EntityType == "Host"),
        any(DeviceName)
    ),
    FileName   = anyif(FileName, EntityType == "File"),
    FolderPath = anyif(FolderPath, EntityType == "File"),
    ProtectionStatus = any(ProtectionStatus),
    SHA1 = any(SHA1)
by Title, TimeGenerated
| extend LocalTime = format_datetime(datetime_add("hour", 6, TimeGenerated), "dd-MM-yyyy HH:mm:ss.fff")
| order by TimeGenerated desc
```
