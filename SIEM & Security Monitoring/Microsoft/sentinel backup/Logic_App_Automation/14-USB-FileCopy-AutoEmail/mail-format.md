```
Dear Concern,

A USB file transfer activity has been detected on an endpoint device. The details of the activity are provided below for review.

Incident Summary
Device Name: @{items('For_each_1')?['DeviceName']}
User Account: @{items('For_each_1')?['User']}
USB Device: @{items('For_each_1')?['USB_Device']}
USB Serial Number: @{items('For_each_1')?['USB_Serial']}
Manufacturer: @{items('For_each_1')?['Manufacturer']}

File Transfer Details
Total Files Copied: @{items('For_each_1')?['TotalFilesCopied']}
Total Data Copied (MB): @{items('For_each_1')?['TotalDataCopiedMB']}

Top Files Copied
@{join(items('For_each_1')?['TopFiles'], '
• ')}

This activity indicates that files were copied from the endpoint device to an external USB storage device. Please review the activity to determine whether it is authorized.

Regards,
SOC Team
ELEVATE SOLUTIONS LIMITED
```
