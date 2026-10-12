# AutoKMS-Detection

![alt text](./image/image.png)
![alt text](./image/image-1.png)
![alt text](./image/image-2.png)


KQL:
```sql
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

Mail Format:

```
Dear Concern,

I hope this message finds you well.

Summary of the Alert:
The alert was generated due to the presence of an activation tool .This type of activation tool is classified as a hacktool and is commonly used to bypass legitimate software licensing mechanisms.

Impact Analysis:
Title : @{item()?['Title']}
Alert ID : @{item()?['AlertId']}
Alert Time Local : @{item()?['LocalLastSeen']}
Last Seen UTC : @{item()?['LastSeen']}
Device Name : @{item()?['DeviceName']}
Device ID : @{item()?['DeviceId']}
Account Name : @{item()?['AccountName']}
Account Domain : @{item()?['AccountDomain']}
Folder Path : @{item()?['FolderPaths']}
File Name : @{item()?['FileNames']}
SHA1 : @{item()?['SHA1s']}
SHA256 : @{item()?['SHA256s']}
File Size : @{item()?['FileSize_MB']} MB

Cause of the Alert:
The alert was triggered due to the execution and/or detection of a known activation tool (hacktool) on the endpoint, identified through process activity and file indicators matching commonly used unauthorized software activation utilities.

Please review the activity to determine whether it is authorized.

If you require any additional clarification or assistance, please feel free to let us know.
Thanking you.

Regards,
SOC Team
ELEVATE SOLUTIONS LIMITED
```

