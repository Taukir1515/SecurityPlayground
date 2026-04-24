```
Dear Team,

I hope this message finds you well.

I would like to inform you regarding the alert titled "External Port Scan Detection".

Summary of the Alert:
The alert was generated after multiple connection attempts were observed from multiple external IP addresses targeting a device across numerous distinct network ports within a short time window, indicating potential port scanning activity.

Impact Analysis:
Time Generated (UTC) : @{item()?['TimeGenerated']}
Local Time (BD) : @{item()?['LocalTime']}
Device Name : @{item()?['DeviceName']}
Device ID : @{item()?['DeviceId']}
Attack Type : @{item()?['AttackType']}
Remote Port Count : @{item()?['RemotePortCount']}
Remote IP Count : @{item()?['RemoteIPCount']}
Port : IP =
@{item()?['SinglePort_IPs']}

Cause of the Alert:
The analytics rule identified external IP addresses initiating connections to a single device on a high number of unique destination ports, exceeding the defined port scan threshold.

Please review the activity to determine whether it is authorized.

If you require any additional clarification or assistance, please feel free to let us know.
Thanking you.

Regards,
SOC Team
ELEVATE SOLUTIONS LIMITED
```