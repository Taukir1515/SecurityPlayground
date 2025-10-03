# netplan Location
```
/etc/netplan/50-cloud-init.yaml
```

# Show Gateway 
```bash
ip route
```

# Show DNS server
```bash
resolvectl
```

# Static IP Configuration
```
network:
  version: 2
  renderer: networkd
  ethernets:
    ens33:  # Check Interface name using `ip a or ifconfig`
      dhcp4: no
      addresses: [192.168.1.100/24]
      gateway4: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
```

```bash
sudo netplan apply
```
