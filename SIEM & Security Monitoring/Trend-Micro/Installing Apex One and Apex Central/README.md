<!-- omit in toc -->
# Trend Micro Installation and Deployment Guideline
<!-- omit in toc -->
## Table of Content
- [Minimum Windows Server Requirement](#minimum-windows-server-requirement)
- [Install Windows Server](#install-windows-server)
- [Install SQL Server](#install-sql-server)
- [Install SQL Server Management Studio (SSMS)](#install-sql-server-management-studio-ssms)
- [Install Trend Micro](#install-trend-micro)
  - [Trend Micro Apex One](#trend-micro-apex-one)
  - [Trend Micro Apex One Patch](#trend-micro-apex-one-patch)
- [Update Trend Micro Apex One Service Pack](#update-trend-micro-apex-one-service-pack)
- [Apex One Web Console](#apex-one-web-console)
- [Download Agent Installer](#download-agent-installer)
- [Install Agent to Endpoint](#install-agent-to-endpoint)
- [Install IIS on Windows Server](#install-iis-on-windows-server)
  - [Troubleshooting IIS ASP Issue (In case required)](#troubleshooting-iis-asp-issue-in-case-required)
- [Install Trend Micro Apex Central](#install-trend-micro-apex-central)
- [Connect Apex One and Apex Central](#connect-apex-one-and-apex-central)
  - [Apex One ==\> Apex Central](#apex-one--apex-central)
  - [Apex Central ==\> Apex One](#apex-central--apex-one)


# Minimum Windows Server Requirement

| Item | Requirement |
|--------|-------------|
| **Supported Editions** | Standard, Datacenter, Server Core |
| **Processor** | Minimum 1.4 GHz Intel Pentium or equivalent (2 GHz recommended) |
| **Processor Architecture** | AMD 64 Processor, Intel 64 Processor |
| **RAM** | 2 GB minimum (dedicated exclusively for Apex One) |
| **RAM (with Endpoint Sensor)** | 2 GB minimum (dedicated exclusively for Apex One) |
| **Available Disk Space** | 1.5 GB minimum |
| **Recommended Disk Space** | 2.0 GB recommended |
| **Additional Disk Space** | 3.0 GB recommended if Application Control, Endpoint Sensor, Vulnerability Protection, and Data Protection are enabled |


**Reference**
```
https://docs.trendmicro.com/en-us/documentation/article/apex-one-as-a-service-online-help-windows-server-2025-
```

# Install Windows Server
Recommended Windows Server Version: 2019 / 2022 / 2025

# Install SQL Server

>[!Important]  
Use SQL Server version CU4 or above, NEVER use SQL server 2019 Evolution version.   
**Refence:**
[SQL version selection](https://success.trendmicro.com/en-US/solution/KA-0003711)

Version used **SQL Server 2022 licensed version**

> [!NOTE]   
Having Trend Micro and SQL Server in the same Windows Server is good practice for small and medium infrastructure.


**Install by following the below steps:**

![alt text](./image/01.png)

![alt text](./image/02.png)

![alt text](./image/03.png)

![alt text](./image/04.png)

![alt text](./image/05.png)

![alt text](./image/06.png)

![alt text](./image/07.png)

![alt text](./image/08.png)

**Note the System Admin (sa) password:**

![alt text](./image/09.png)

![alt text](./image/10.png)


# Install SQL Server Management Studio (SSMS) 

- Can be installed any version of SSMS other than SQL Server.
- Used Version: SQL Server Management Studio 22


1.	Download Link:
```bash
https://learn.microsoft.com/en-us/ssms/install/install
```
![alt text](./image/25.png)

2.	Run the SSMS file:

![alt text](./image/26.png)

![alt text](./image/27.png)

3.	Use default settings: 

![alt text](./image/28.png)

![alt text](./image/29.png)

![alt text](./image/29.png)

![alt text](./image/30.png)

![alt text](./image/31.png)

Open `SQL Server Management Studio (SSMS)`

![alt text](./image/31a.png)

# Install Trend Micro

## Trend Micro Apex One
1. Trend Micro Apex One Download Link
```
https://downloadcenter.trendmicro.com/index.php?regs=NABU&clk=latest&clkval=5347&lang_loc=1
```

2. Download both the `Installation iso` and the `Patch` with latest version.

![alt text](./image/32.png)

3. Install `Trend Micro Apex One` with `Administrative` permission

![alt text](./image/33.png)

![alt text](./image/34.png)

6.	Restart the Server:

![alt text](./image/35.png)

7. After Restart, Apex One will start automatically.    

![alt text](./image/36.png)

![alt text](./image/37.png)

![alt text](./image/38.png)

![alt text](./image/39.png)


Put the Trend Micro Apex One Activation Code

![alt text](./image/40.png)

![alt text](./image/41.png)

![alt text](./image/42.png)

Suggested to use FQDN or hostname
![alt text](./image/43.png)

![alt text](./image/44.png)

If there is a license of Endpoint Sensor, check the box. 

![alt text](./image/45.png)

![alt text](./image/46.png)

![alt text](./image/47.png)

![alt text](./image/48.png)

![alt text](./image/49.png)

![alt text](./image/50.png)

![alt text](./image/51.png)

![alt text](./image/52.png)

![alt text](./image/53.png)

![alt text](./image/54.png)

![alt text](./image/55.png)

![alt text](./image/56.png)  


Generate Backup Password  

![alt text](./image/57.png)

Minimum 10 characters with Uppercase, lowercase, number and special characters.

[NOTE]Remember these Username and password.

![alt text](./image/58.png)

Create Start Menu folder

![alt text](./image/59.png)

![alt text](./image/60.png)

![alt text](./image/61.png)

![alt text](./image/62.png)

## Trend Micro Apex One Patch 

Run the patch file as Administrator

![alt text](./image/63.png)

![alt text](./image/64.png)

![alt text](./image/65.png)

![alt text](./image/66.png)

![alt text](./image/67.png)


# Update Trend Micro Apex One Service Pack

![alt text](./image/68.png)

![alt text](./image/69.png)

![alt text](./image/70.png)

# Apex One Web Console

Access Link:
```
https://Server_IP:4343/officescan/console/html/cgi/cgiChkMasterPwd.exe
```

Open Apex One Web Console (HTML)

![alt text](./image/71.png)

![alt text](./image/72.png)


![alt text](./image/73.png)

![alt text](./image/74.png)

![alt text](./image/75.png)

# Download Agent Installer
Log out from **Apex One** session.


Click on installer. 
![alt text](./image/76.png)

![alt text](./image/77.png)

>[!Note]
This msi installer can be distributed via network share or USB pen drive. Local PC and the server must be on the same network.

![alt text](./image/78.png)

![alt text](./image/79.png)


![alt text](./image/80.png)

# Install Agent to Endpoint

Go to `Agents` >> `Agent Management`  

Check the onboarded Endpoint:

![alt text](./image/80a.png)

# Install IIS on Windows Server
Go to Server Manager

![alt text](./image/81.png)

![alt text](./image/82.png)

![alt text](./image/83.png)

![alt text](./image/84.png)

![alt text](./image/85.png)

![alt text](./image/86.png)

![alt text](./image/87.png)

![alt text](./image/88.png)

![alt text](./image/89.png)

![alt text](./image/90.png)


![alt text](./image/91.png)

![alt text](./image/92.png)

![alt text](./image/93.png)

![alt text](./image/94.png)


## Troubleshooting IIS ASP Issue (In case required)

**Root Cause:** 
- `ASP` doesn't check while selecting Roles in `Role Services`

**Fixing via Powershell:**

```pw1
Install-WindowsFeature Web-ASP
Get-WindowsFeature Web-ASP
```
Expected output:
```
[X] ASP
```

Reboot the server
```
Restart-Computer
```


# Install Trend Micro Apex Central

Download Link:

```
https://downloadcenter.trendmicro.com/index.php?regs=nabu&prodid=1746&_ga=2.88444699.1026483528.1789447897-991840843.1789447897
```

Use Activation code of Trend Micro Apex One

Web console URL:
```
https://192.168.64.134/webapp/index.html
```

# Connect Apex One and Apex Central

## Apex One ==> Apex Central

1. Login Apex One console

2. Go to Apex Central Settings  

`Administration >> Settings >> Apex Central`

![alt text](./image/95.png)

For `IIS web server authentication`,  
Username = Apex Central Username
password = Apex Central Password


![alt text](./image/96.png)


Test and Upload the connection:  

![alt text](./image/97.png)

## Apex Central ==> Apex One

1. Login Apex Central console  


`Directories >> Products`

![alt text](./image/98.png)

![alt text](./image/99.png)

>[!Note]
By Default, the Apex One server is placed under `New Entity`. But we need to create a `New Folde`r under "`Local Folder`" and move the Apex One server to the `New Folder`



Check the connection status:

![alt text](./image/100.png)

