```
Dear Concern,

I hope this message finds you well.

I would like to inform you regarding the incident titled "TI Map IP Entity to SigninLogs".

Summary of the Alert:
Microsoft Sentinel detected a sign‑in activity associated with an IP address flagged as malicious by Threat Intelligence.

Impact Analysis:
Event Time BD : @{item()?['LocalTime_BD']}
User Principal Name : @{item()?['UserPrincipalName']}
Name : @{item()?['Name']}
UPN Suffix : @{item()?['UPNSuffix']}

Status Code : @{item()?['StatusCode']}
Status Reason : @{item()?['StatusReason']}
Status Details : @{item()?['StatusDetails']}
Affected Application : @{item()?['AppDisplayName']}

Network Source IP : @{item()?['NetworkSourceIP']}
Confidence : @{item()?['Confidence']}

Type : @{item()?['Type']}
URL : @{item()?['Url']}

Cause of the Alert:
The alert was triggered due to a match between a known malicious IP address and sign‑in activity for the user account @{item()?['UserPrincipalName']}.

If you require any additional clarification or assistance, please feel free to let us know.
Thanking you.

Regards,
SOC Team
ELEVATE SOLUTIONS LIMITED
```