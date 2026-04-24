```kql
let Lookback = 30m;
AlertEvidence
| where TimeGenerated > ago(Lookback)
| where Title contains "AutoKMS" or Title contains "Winactivator"
| summarize
    Title= any(Title),
    FirstSeen     = min(TimeGenerated),
    LastSeen      = max(TimeGenerated),
    DeviceName    = anyif(DeviceName, isnotempty(DeviceName)),
    DeviceId      = anyif(DeviceId, isnotempty(DeviceId)),
    AccountName   = anyif(AccountName, isnotempty(AccountName)),
    AccountDomain = anyif(AccountDomain, isnotempty(AccountDomain)),
    FolderPaths   = anyif(FolderPath, isnotempty(FolderPath)),
    FileNames     = anyif(FileName, isnotempty(FileName)),
    SHA1s         = anyif(SHA1, isnotempty(SHA1)),
    SHA256s       = anyif(SHA256, isnotempty(SHA256)),
    MaxFileSize_Byte = anyif(FileSize, isnotempty(FileSize))
  by AlertId
| extend 
    LocalLastSeen = format_datetime(datetime_add("hour", 6, LastSeen), "dd-MM-yyyy HH:mm:ss.fff"),
    FileSize_MB = round(MaxFileSize_Byte / 1024.0 / 1024.0, 3)
| order by LastSeen desc
```
