```
Dear Team,

I hope this message finds you well.

I would like to inform you regarding the alert titled "@{item()?['Title']}".

Summary of the Alert:
The alert was generated after network activity from a device was observed communicating with an IP address flagged as malicious by Microsoft Threat Intelligence. This detection indicates a potential exposure to known threat‑associated infrastructure based on IoC correlation.

Impact Analysis:
Title : @{item()?['Title']}
Alert ID : @{item()?['AlertId']}
Alert Time (BD) : @{item()?['LocalTime']}

SourceIP : @{item()?['SourceIP']}

Source IP Count: @{item()?['SourceIPCount']}
Confidence : @{item()?['Confidence']}
Remote Port : @{item()?['RemotePort']}
Remote Port Count: @{item()?['RemotePortCount']}
Remote URL: @{item()?['RemoteUrl']}
Description : @{item()?['Description']}
Type : @{item()?['Type']}
Action Type : @{item()?['ActionType']}
DeviceName : @{item()?['DeviceName']}
Device ID: @{item()?['DeviceId']}
Account Domain : @{item()?['InitiatingProcessAccountDomain']}
Account Name : @{item()?['InitiatingProcessAccountName']}
Account Sid : @{item()?['InitiatingProcessAccountSid']}
Account Upn : @{item()?['InitiatingProcessAccountUpn']}
File Name : @{item()?['InitiatingProcessFileName']}
Folder Path: @{item()?['InitiatingProcessFolderPath']}
MD5 Value : @{item()?['InitiatingProcessMD5']}
File Size : @{item()?['InitiatingProcessFileSize']}
Local Port : @{item()?['LocalPort']}
Device OS : @{item()?['MachineGroup']}

Cause of the Alert:
The analytics rule identified a device network connection involving an IP address that matches a known threat intelligence indicator of compromise (IoC). DeviceNetworkEvents logs were reviewed to validate the network activity and confirm the IoC match.

Please review the activity to determine whether it is authorized.

If you require any additional clarification or assistance, please feel free to let us know.
Thanking you.

Regards,
SOC Team
ELEVATE SOLUTIONS LIMITED
```