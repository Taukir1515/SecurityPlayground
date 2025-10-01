# Installing VM Tools for Vmware

## For Installation
```
sudo apt install open-vm-tools open-vm-tools-desktop -y
```
## Check installed version of VMware Tools
```
vmware-toolbox-cmd -v
```

## Restart open-vm-tools
```
sudo systemctl restart open-vm-tools
```
