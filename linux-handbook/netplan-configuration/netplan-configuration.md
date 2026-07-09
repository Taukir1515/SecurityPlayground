# Configuration with Custom DNS Server
```
network:
  version: 2
  renderer: networkd
  ethernets:
    ens33:   # NAT Interface (Static IP for Internet)
      addresses:
        - 192.168.13.100/24  # Example NAT IP
      gateway4: 192.168.13.2  # NAT Gateway
      nameservers:
        addresses:
          - 192.168.13.100  # IP of DNS server
```
# Configuration with Default DNS Server
```
network:
  version: 2
  renderer: networkd
  ethernets:
    ens33:
      addresses:
        - 192.168.64.128/24
      routes:
        - to: default
          via: 192.168.64.2
      nameservers:
        addresses:
          - 8.8.8.8
          - 1.1.1.1
```

# Configuration with DHCP ON
```
network:
  version: 2
  renderer: networkd
  ethernets:
    ens33:
      dhcp4: true
```
