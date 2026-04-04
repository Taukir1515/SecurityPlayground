
<!-- omit in toc -->
# Automation Process
<!-- omit in toc -->
## Table of Content
- [Logic App](#logic-app)
  - [Create Logic App](#create-logic-app)
  - [Open Logic App](#open-logic-app)
  - [Add to Identity](#add-to-identity)
  - [Add to Access Control (IAM)](#add-to-access-control-iam)
  - [Edit the Logic App](#edit-the-logic-app)
- [Testing KQL Query](#testing-kql-query)
- [Sentinel Automation](#sentinel-automation)


## Logic App
### Create Logic App
![alt text](./image/01.png)
![alt text](./image/02.png)
![alt text](./image/03.png)
![alt text](./image/04.png)
![alt text](./image/05.png)

### Open Logic App
![alt text](./image/06.png)

### Add to Identity
![alt text](./image/07.png)

### Add to Access Control (IAM)
![alt text](./image/08.png)
![alt text](./image/09.png)
![alt text](./image/10.png)
![alt text](./image/11.png)
![alt text](./image/12.png)

### Edit the Logic App
1. Add Trigger **Microsoft Sentinel incident**

![alt text](./image/13.png)

2. Add Action **Run query and list results**

![alt text](./image/14.png)
![alt text](./image/15.png)

**Change Connection, if required (OPTIONAL)**
![alt text](./image/16.png)

1. Add action **For each**

![alt text](./image/17.png)
![alt text](./image/18.png)
![alt text](./image/19.png)

4. Add an Action **Send an email (V2)** inside **For each** Action

![alt text](./image/20.png)

**Change Connection, if required (OPTIONAL)**
![alt text](./image/21.png)

5. **Save** and **Run** for Testing

![alt text](./image/22.png)

## Testing KQL Query
Go to  `Microsoft Sentinel` > `Logs`

![alt text](./image/23.png)


## Sentinel Automation

`Microsoft Sentinel` > `Configuration` > `Automation`

![alt text](./image/24.png)
![alt text](./image/25.png)