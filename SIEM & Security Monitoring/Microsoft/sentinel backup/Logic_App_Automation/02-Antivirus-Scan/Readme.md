# Antivirus-Scan


![alt text](./image/image.png)
![alt text](./image/image-1.png)
![alt text](./image/image-2.png)

KQL Query:
```sql
AlertEvidence
| where TimeGenerated >= ago(24h)
|where Title contains "'Cerdigent'"
| distinct DeviceId
```

