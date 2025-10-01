# Ubuntu root Partition Extension

## Check the Current Layout

```bash
lsblk
df -hT /
```

Sample Output:

```
sda      25G
└─sda3   20G   /
```

Here, disk is bigger, but root partition is still small.

## Install Growpart

```bash
sudo apt update
sudo apt install cloud-guest-utils -y
```

## Grow the Partition

```bash
sudo growpart /dev/sda 3
```
- /dev/sda --> the disk

- 3 --> the partition number (here sda3 is root)

## Grow the Filesystem

### Check Filesystem:
```bash
df -T /
```
### If root is ext4:
```bash
sudo resize2fs /dev/sda3
```

### If root is xfs
```bash
sudo xfs_growfs /
```

## Verify
```bash
df -hT /
```




