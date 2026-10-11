
<!-- omit in toc -->
# Microsoft Sentinel Automation Rules
<!-- omit in toc -->
## Table of Content

- [AD user enabled and password not set within 48 hours](#ad-user-enabled-and-password-not-set-within-48-hours)
- [Persistence \& Privilege escalation](#persistence--privilege-escalation)
- [Files Copied to USB Drives](#files-copied-to-usb-drives)
- [Change Incident Status](#change-incident-status)
- [Potential beaconing activity (ASIM Network Session schema)](#potential-beaconing-activity-asim-network-session-schema)
- [Modification attempt in Microsoft Defender Antivirus exclusion list](#modification-attempt-in-microsoft-defender-antivirus-exclusion-list)
- [Rare and potentially high-risk Office operations](#rare-and-potentially-high-risk-office-operations)
- [SharePointFileOperation via devices with previously unseen user agents](#sharepointfileoperation-via-devices-with-previously-unseen-user-agents)
- [Potential SQL Injection](#potential-sql-injection)
- [KMS Hacktool Detection \[Disabled\]](#kms-hacktool-detection-disabled)
- [KMS Hacktool Detection - Incident Updated \[Disabled\]](#kms-hacktool-detection---incident-updated-disabled)
- ['AutoKMS' hacktool was prevented](#autokms-hacktool-was-prevented)
- [AutoKMS hacktool detected](#autokms-hacktool-detected)
- [Winactivator hacktool](#winactivator-hacktool)
- [TI Map IP Entity to SigninLogs](#ti-map-ip-entity-to-signinlogs)
- [TI Map IP Entity to SigninLogs - Incident Updated](#ti-map-ip-entity-to-signinlogs---incident-updated)
- [TI Map IP Entity to DeviceNetworkEvents](#ti-map-ip-entity-to-devicenetworkevents)
- [TI Map IP Entity to DeviceNetworkEvents - Incident Updated](#ti-map-ip-entity-to-devicenetworkevents---incident-updated)
- [TI Map IP Entity to CommonSecurityLog](#ti-map-ip-entity-to-commonsecuritylog)
- [TI Map IP Entity to CommonSecurityLog-Incident-Updated](#ti-map-ip-entity-to-commonsecuritylog-incident-updated)
- [TI IoC Match – Network Session](#ti-ioc-match--network-session)
- [TI-IoC-Match-Web-Request](#ti-ioc-match-web-request)
- [External Port Scan](#external-port-scan)
- [External Port Scan - Incident Updated](#external-port-scan---incident-updated)
- [Malicious Process kill \[Disabled\]](#malicious-process-kill-disabled)
- [Office365 Sharepoint File transfer Folders above threshold](#office365-sharepoint-file-transfer-folders-above-threshold)
- [Office365 Sharepoint File transfer above threshold](#office365-sharepoint-file-transfer-above-threshold)
- [SharePointFileOperation via devices with previously unseen user agents](#sharepointfileoperation-via-devices-with-previously-unseen-user-agents-1)
- [SharePointFileOperation via previously unseen IPs](#sharepointfileoperation-via-previously-unseen-ips)
- [Email messages removed after delivery](#email-messages-removed-after-delivery)
- [Fortinet - Beacon Pattern Detected](#fortinet---beacon-pattern-detected)
- [RDP-Logon-Detection](#rdp-logon-detection)
- ['Cerber' ransomware was prevented including Ransomware](#cerber-ransomware-was-prevented-including-ransomware)
- [Anomalous VPN Access from New Source IP (Cisco Firewall Logs)](#anomalous-vpn-access-from-new-source-ip-cisco-firewall-logs)
- [Cisco Firewall Deny Traffic Spike](#cisco-firewall-deny-traffic-spike)


# AD user enabled and password not set within 48 hours

![alt text](./images/001.png)
![alt text](./images/002.png)



Root Cause:
```
Root Cause: Some user accounts were created or reset without enforcing password change at first login.
Elevated Action: We enabled the “User must change password at next logon” option for all new and reset accounts.
Q Collection Action: Admin sets the password, and users are not required to change it.
```

# Persistence & Privilege escalation

![alt text](./images/003.png)
![alt text](./images/004.png)
![alt text](./images/005.png)
![alt text](./images/006.png)


# Files Copied to USB Drives

![alt text](./images/007.png)
![alt text](./images/008.png)

Root Cause: 

```
Root Cause: Files Copied to USB Drives.
Elevated Action: We reviewed the alert, validated the file transfer activity, and performed a full antivirus scan on the impacted device.
Q Collection Action: Confirm whether the USB usage was authorized.
```

# Change Incident Status

![alt text](./images/009.png)



# Potential beaconing activity (ASIM Network Session schema)

![alt text](./images/010.png)
![alt text](./images/011.png)

Root Cause:
```
Root Cause: The alert was triggered due to legitimate communication between an internal IP and Microsoft/Azure platform IPs.
Elevated Action: We reviewed logs, traffic patterns, and related activities and confirmed no malicious behavior.
Q Collection Action: No action required.
```


# Modification attempt in Microsoft Defender Antivirus exclusion list

![alt text](./images/012.png)
![alt text](./images/013.png)

Root Cause: 

```
Root Cause: The alert was triggered due to rare and potentially high-risk Microsoft Office operations involving a single user account
Elevated Action: The SOC team conducted detailed log analysis including review of user sign-in logs, IP address validation, authentication methods, and related alert correlation
Q Collection Action: No action required.
```


# Rare and potentially high-risk Office operations

![alt text](./images/014.png)
![alt text](./images/015.png)

Root Cause: 
```
Root Cause: Rare and potentially high-risk Office operations 
Elevated Action: Activities are reviewed and confirmed as legitimate system/service behavior from Microsoft infrastructure. 
Q Collection Action: No action required.
```


# SharePointFileOperation via devices with previously unseen user agents

![alt text](./images/016.png)
![alt text](./images/017.png)

Root Cause:
```
Root Cause: File operations in SharePoint were performed from a device with a previously unseen user agent, exceeding the default threshold.
Elevated Action: We reviewed the alert and confirmed the URLs, IPs, and user activity were legitimate.
Q Collection Action: No action required.
```



# Potential SQL Injection

![alt text](./images/018.png)
![alt text](./images/019.png)

Root Cuase:

```
Root Cause: SQL parsing error detected, indicating a potential SQL injection attempt in application logs.
Elevated Action: Alert was automatically processed and determined to have no confirmed exploitation or impact.
Q Collection Action: No action required.
```


# KMS Hacktool Detection [Disabled]

![alt text](./images/020.png)
![alt text](./images/021.png)


# KMS Hacktool Detection - Incident Updated [Disabled]

![alt text](./images/022.png)
![alt text](./images/023.png)

# 'AutoKMS' hacktool was prevented

![alt text](./images/024.png)
![alt text](./images/025.png)

**Conditions:**
```
 'AutoKMS' hacktool was prevented
```

OR

```
'AutoKms' hacktool was prevented
```

Root Cause:
```
Root Cause: AutoKMS artifacts detected and prevented.
Elevated Action: Microsoft Defender automatically blocked and prevented the malicious tools from executing on the endpoint.
Q Collection Action: No action required.
```

# AutoKMS hacktool detected

![alt text](./images/026.png)
![alt text](./images/027.png)

**Conditions**
```
An active 'AutoKMS' hacktool was detected
```
OR
```
'AutoKMS' detected on one endpoint
```

OR

```
AutoKMS
```

Root Cause:

```
Root Cause: Detection of an unauthorized activation tool (KMS) on the endpoint.
Elevated Action: Process and file activity were analyzed based on detection indicators.
Q Collection Action: User advised to verify whether the tool usage is authorized.
```


# Winactivator hacktool

![alt text](./images/028.png)
![alt text](./images/029.png)

Root Cause:

```
Root Cause: Winactivator hacktool flagged as malicious, was prevented on the endpoint
Elevated Action: The file was automatically blocked and prevented from execution by endpoint security controls.
Q Collection Action: User advised to verify whether the tool usage is authorized.
```

# TI Map IP Entity to SigninLogs

![alt text](./images/030.png)
![alt text](./images/031.png)

Root Cause:
```
Root Cause:  TI flagged IP sign‑in detected.
Elevated Action: Azure AD sign‑in activity and threat intelligence correlation were reviewed to validate the IOC match.
Q Collection Action: Please review the sign‑in activity to confirm whether it was authorized.
```

# TI Map IP Entity to SigninLogs - Incident Updated

![alt text](./images/032.png)
![alt text](./images/033.png)

Root Cause:
```
Root Cause:  TI flagged IP sign‑in detected.
Elevated Action: Azure AD sign‑in activity and threat intelligence correlation were reviewed to validate the IOC match.
Q Collection Action: Please review the sign‑in activity to confirm whether it was authorized.
```

# TI Map IP Entity to DeviceNetworkEvents

![alt text](./images/034.png)
![alt text](./images/035.png)


Root Cause:

```
Root Cause: TI flagged IP detected in DeviceNetworkEvents.  
Elevated Action: DeviceNetworkEvents logs and IoC matches were reviewed.  
Q Collection Action: Please confirm whether the network activity was authorized.
```

# TI Map IP Entity to DeviceNetworkEvents - Incident Updated

![alt text](./images/036.png)
![alt text](./images/037.png)

Root Cause:

```
Root Cause: TI flagged IP detected in DeviceNetworkEvents.  
Elevated Action: DeviceNetworkEvents logs and IoC matches were reviewed.  
Q Collection Action: Please confirm whether the network activity was authorized.
```


# TI Map IP Entity to CommonSecurityLog

![alt text](./images/038.png)
![alt text](./images/039.png)

Root Cause:

```
Root Cause: TI matched IP detected in CommonSecurityLog
Elevated Action: CommonSecurityLog events and threat intelligence matches were reviewed to validate the IOC correlation.
Q Collection Action: Please review the related activity to confirm whether it is authorized.
```

# TI Map IP Entity to CommonSecurityLog-Incident-Updated

![alt text](./images/040.png)
![alt text](./images/041.png)

Root Cause:

```
Root Cause: TI matched IP detected in CommonSecurityLog
Elevated Action: CommonSecurityLog events and threat intelligence matches were reviewed to validate the IOC correlation.
Q Collection Action: Please review the related activity to confirm whether it is authorized.
```

# TI IoC Match – Network Session

![alt text](./images/042.png)
![alt text](./images/043.png)

Root Cause:

```
Root Cause: A network session source IP matched a known Threat Intelligence indicator of compromise.
Elevated Action: ASIM Network Session events and the associated IoC correlation were reviewed.
Q Collection Action: Please confirm whether the source IP is expected or business‑related, and whether any communication with this IP should be blocked or further investigated.
```


# TI-IoC-Match-Web-Request

![alt text](./images/044.png)
![alt text](./images/045.png)

Root Cause:

```
Root Cause: TI flagged source IP detected in web session activity.
Elevated Action: ASIM web session logs and IOC correlation were reviewed for validation.
Q Collection Action: Please confirm whether the web request activity was authorized.
```

# External Port Scan

![alt text](./images/046.png)
![alt text](./images/047.png)

Root Cause:
```
Root Cause: External port scanning detected
Elevate Action: SOC validated the activity as external port scanning
Q Collection Action: No Action Required.
```

# External Port Scan - Incident Updated
![alt text](./images/050.png)
![alt text](./images/051.png)

Root Cause:
```
Root Cause: External port scanning detected
Elevate Action: SOC validated the activity as external port scanning
Q Collection Action: No Action Required.
```

# Malicious Process kill [Disabled]

![alt text](./images/048.png)
![alt text](./images/049.png)



# Office365 Sharepoint File transfer Folders above threshold

![alt text](./images/052.png)
![alt text](./images/053.png)

Root Cause:

```
Root Cause: The account was used by a non-interactive process, automated client, or compromised identity that accessed or moved files at scale.
Elevate Action: Uaer has been Verified,confirm if this was legitimate OneDrive sync or malicious bulk download.
Q Collection Action : No action required .
```

# Office365 Sharepoint File transfer above threshold

![alt text](./images/056.png)
![alt text](./images/057.png)

Root Cause: 

```
Root Cause: The alert was generated due to extremely high‑volume SharePoint/OneDrive file activity.
Elevate Action : Verify user and source IP.
Q Collection Action : No action required.
```



# SharePointFileOperation via devices with previously unseen user agents

![alt text](./images/054.png)
![alt text](./images/055.png)

Root Cause:
```
Root Cause : The activity indicates abnormal SharePoint file operations performed using a new or a typical User-Agent.
Elevate Action: User Identified.
Q Collection Action: No action required.
```




# SharePointFileOperation via previously unseen IPs

![alt text](./images/058.png)
![alt text](./images/059.png)

**Conditions**
```
SharePointFileOperation via previously unseen IPs
```


Root Cause:

```
Root Cause: The alert was triggered by SharePoint file activity far exceeding the user’s normal baseline, suggesting automation or potential data exfiltration.
Elevate Action : validated of the user’s activity, User-Agent, ClientIP.
Q Collection Action : No action required.
```


# Email messages removed after delivery

![alt text](./images/060.png)
![alt text](./images/061.png)

Conditions:

```
Email messages containing malicious file removed after delivery
```

OR

```
Email messages containing malicious URL removed after delivery
```

OR

```
Email messages removed after delivery
```


Root Cause:

```
Root Cause: Malicious email campaign triggered detection.
SOC Team Action: Defender removed emails and SOC reviewed activity.
Q Collection Action: No action required. 
```

# Fortinet - Beacon Pattern Detected

![alt text](./images/062.png)
![alt text](./images/063.png)

Root Cause:

```
Root Cause : Internal host communication with multiple external ip addresses.
Elevate Action : Check active processes and analyze parent-child relationships to identify suspicious or unauthorized activity.
Q Collection Action : No action required.
```

# RDP-Logon-Detection

![alt text](./images/064.png)
![alt text](./images/065.png)


# 'Cerber' ransomware was prevented including Ransomware

![alt text](./images/066.png)
![alt text](./images/067.png)


Root Cause:

```
Root Cause: Unauthorized Cerber malware was detected and later blocked.
SOC Team Action: Microsoft Defender successfully prevented the malware execution and the related file activity was reviewed.
Q Collection Action: No action required.
```

# Anomalous VPN Access from New Source IP (Cisco Firewall Logs)

![alt text](./images/068.png)
![alt text](./images/069.png)

# Cisco Firewall Deny Traffic Spike

![alt text](./images/070.png)
![alt text](./images/071.png)

Root Cause:
```
Root Cause: Outbound connections from internal device blocked by firewall.
SOC Team Action: Validated traffic pattern shows normal application behavior with denied connections due to firewall policy; no malicious indicators found.
Q Collection Action: No action required.
```




