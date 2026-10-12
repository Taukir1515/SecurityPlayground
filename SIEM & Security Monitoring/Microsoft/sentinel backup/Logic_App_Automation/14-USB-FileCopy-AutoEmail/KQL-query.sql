DeviceFileEvents
| where Timestamp > ago(1h)
| where ActionType == "FileCreated"
| where InitiatingProcessAccountName != "system"
| where FolderPath matches regex @"^[D-Z]:\\"
| project Timestamp, DeviceId, DeviceName,
         User = InitiatingProcessAccountName,
         FileName, FolderPath, FileSize, SHA256
| join kind=inner (
    DeviceEvents
    | where ActionType == "UsbDriveMounted"
    | extend Parsed=parse_json(AdditionalFields)
    | project DeviceId,
             DriveLetter=tostring(Parsed.DriveLetter),
             ProductName=tostring(Parsed.ProductName),
             SerialNumber=tostring(Parsed.SerialNumber),
             Manufacturer=tostring(Parsed.Manufacturer),
             MountTime=Timestamp
) on DeviceId
| where FolderPath startswith DriveLetter
| where Timestamp >= MountTime
| summarize
    TotalFilesCopied = count(),
    TotalDataCopiedMB = round(sum(FileSize)/1024/1024,2),
    TopFiles = make_list(FileName,10)
    by DeviceName,User,ProductName,SerialNumber,Manufacturer
| project
    DeviceName,
    User,
    USB_Device = ProductName,
    USB_Serial = SerialNumber,
    Manufacturer,
    TotalFilesCopied,
    TotalDataCopiedMB,
    TopFiles