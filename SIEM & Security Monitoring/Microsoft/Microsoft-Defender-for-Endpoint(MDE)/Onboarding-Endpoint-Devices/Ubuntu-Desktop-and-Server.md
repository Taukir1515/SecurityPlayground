# Onboarding Ubuntu Desktop and Ubuntu Server on MDE

## Install required packages

```bash
sudo apt-get update
sudo apt-get install -y curl libplist-utils apt-transport-https gpg gnupg
```

## Add the 24.04 repo (use HTTPS)

```bash
curl -o microsoft.list https://packages.microsoft.com/config/ubuntu/24.04/prod.list
sudo mv microsoft.list /etc/apt/sources.list.d/microsoft-prod.list
```

> [!NOTE]
> Check current version of Ubuntu


```bash
hostnamectl

or

lsb_release -a
```


## Add Microsoft’s signing key

```bash
### Remove any old key you might have dropped into trusted.gpg.d

sudo rm -f /etc/apt/trusted.gpg.d/microsoft.gpg


### Create keyring directory & import Microsoft key

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
  | gpg --dearmor \
  | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null

sudo chmod 0644 /etc/apt/keyrings/microsoft.gpg
```

## Configure the Microsoft repo for Ubuntu 24.04

```bash
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/24.04/prod noble main" \
  | sudo tee /etc/apt/sources.list.d/microsoft-prod.list
```

## Update package lists

```bash
sudo apt-get update
```

## Install the Microsoft Defender for Endpoint Agent

```bash
sudo apt-get install -y mdatp
```

## Initial sanity checks (before onboarding)

```bash
mdatp health
mdatp connectivity test
```

## Download onboarding python script 

```bash
https://security.microsoft.com/securitysettings/endpoints/onboarding
```

> [!OPTIONAL]
> Establish connection via ssh -

```bash
ssh username@IP_address
```

> Transfer file from host device to ubuntu machine

```bash
scp /path/to/script.py username@IP_address:/home/taukir/script.py
```

