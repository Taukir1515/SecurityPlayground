# Microsoft Defender for Identity

## Pre-configuration

### Windows Server
Version: Windows Server 2016 or Later  
RAM : 6 GB or more  
Rename Computer : Kafco-DC-01  


### Configure Active Directory Domain Controller (ADDS)

![alt text](./image/001.png)

![alt text](./image/002.png)

![alt text](./image/003.png)

![alt text](./image/004.png)

![alt text](./image/005.png)

![alt text](./image/006.png)

![alt text](./image/007.png)

![alt text](./image/008.png)

![alt text](./image/009.png)

![alt text](./image/010.png)

![alt text](./image/011.png)

![alt text](./image/012.png)

![alt text](./image/013.png)

![alt text](./image/014.png)

![alt text](./image/015.png)

![alt text](./image/016.png)

![alt text](./image/017.png)


## Directory Service Accounts creation for Microsoft Defender for Identity 


![alt text](./image/018.png)

**Add User to Delegate Control**

![alt text](./image/019.png)

![alt text](./image/020.png)

![alt text](./image/021.png)

![alt text](./image/022.png)

![alt text](./image/023.png)

![alt text](./image/024.png)


## Directory Service Accounts Delegate Control for Microsoft Defender for Identity 

![alt text](./image/025.png)

![alt text](./image/026.png)

![alt text](./image/027.png)

![alt text](./image/028.png)

![alt text](./image/029.png)

![alt text](./image/030.png)

![alt text](./image/031.png)

![alt text](./image/032.png)

![alt text](./image/033.png)

![alt text](./image/034.png)


## Configure Advanced Audit Policy settings for Microsoft Defender for Identity 

![alt text](./image/035.png)

![alt text](./image/036.png)


![alt text](./image/037.png)

![alt text](./image/038.png)

![alt text](./image/039.png)

![alt text](./image/040.png)

![alt text](./image/041.png)

![alt text](./image/042.png)

![alt text](./image/043.png)


## Configure NTLM Audit Policy settings for Microsoft Defender for Identity 

![alt text](./image/044.png)

![alt text](./image/045.png)

![alt text](./image/046.png)


## Configure domain object Auditing Policy settings for Microsoft Defender for Identity 

![alt text](./image/047.png)

![alt text](./image/048.png)

![alt text](./image/049.png)

![alt text](./image/050.png)

![alt text](./image/051.png)

![alt text](./image/052.png)

![alt text](./image/053.png)

- Descendant User objects

![alt text](./image/054.png)

- Descendant Group objects

![alt text](./image/055.png)

![alt text](./image/056.png)

![alt text](./image/057.png)


- Descendant Computer objects

![alt text](./image/058.png)

![alt text](./image/059.png)

![alt text](./image/060.png)


- Descendant msDS-ManagedServiceAccount objects

![alt text](./image/061.png)

![alt text](./image/062.png)

![alt text](./image/063.png)

- Descendant msDS-GroupManagedServiceAccount objects


![alt text](./image/064.png)

![alt text](./image/065.png)


![alt text](./image/066.png)



## Configure Search Results Registry Policy settings for Microsoft Defender for Identity 

![alt text](./image/067.png)

![alt text](./image/068.png)

![alt text](./image/069.png)


- HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics

![alt text](./image/070.png)


- HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters

**Value Name: 15 Field Engineering**

![alt text](./image/071.png)

**Expensive Search Results Threshold**

![alt text](./image/072.png)


**Inefficient Search Results Threshold**


![alt text](./image/073.png)


**Search Time Threshold (msecs)**

![alt text](./image/074.png)



![alt text](./image/075.png)


## Download the Microsoft Defender for Identity  Sensor 

### Method-1

1. Onboard the AD server to MDE.
2. 
![alt text](./image/076.png)

![alt text](./image/077.png)

![alt text](./image/078.png)

![alt text](./image/079.png)


### Method-2

![alt text](./image/080.png)

![alt text](./image/081.png)

![alt text](./image/082.png)

Run the onboarding script to AD server. And the MDI sensor will be installed
