```
Dear Team,

I hope this message finds you well.

I would like to inform you regarding the incident titled @{item()?['Title']}

Summary of the Alert:
Microsoft Sentinel detected a sign‑in activity associated with an IP address flagged as malicious by Threat Intelligence.

Impact Analysis:
Title : @{item()?['Title']}
LocalTime (BD) : @{item()?['LocalTime']}

User Principal Name : @{item()?['UserPrincipalName']}
User ID : @{item()?['UserId']}
User Display Name : @{item()?['UserDisplayName']}

Source IP : @{item()?['SourceIP']}
Source IP Count : @{item()?['SourceIPCount']}
Confidence : @{item()?['Confidence']}
City : @{item()?['City']}
State : @{item()?['State']}
Country : @{item()?['Country']}
Latitude : @{item()?['Latitude']}
Longitude : @{item()?['Longitude']}


Login Status : @{item()?['Login_Status']}
Error Code : @{item()?['Error_Code']}
Error Reason : @{item()?['failureReason']}

MITRE ATTACK Technique : @{item()?['MITRE_ATTACK_Technique']}
Source System : @{item()?['SourceSystem']}
Operation Name : @{item()?['OperationName']}
App Display Name : @{item()?['AppDisplayName']}
Authentication Method : @{item()?['Authentication_Method']}

Cause of the Alert:
The alert was triggered due to a match between a known malicious IP address and @{item()?['SourceSystem']} sign‑in activity for the user account.

Please review the activity to determine whether it is authorized.

If you require any additional clarification or assistance, please feel free to let us know.
Thanking you.

Regards,
SOC Team
ELEVATE SOLUTIONS LIMITED
```