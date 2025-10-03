# Installing VM Tools for Vmware

## Install VM tools

```bash
sudo apt install open-vm-tools open-vm-tools-desktop -y
```
## Check installed version of VMware Tools

```bash
vmware-toolbox-cmd -v
```

## Restart open-vm-tools

```bash
sudo systemctl restart open-vm-tools
```
