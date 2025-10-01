			
			
		=============================================================
		=	        OverTheWire				    =				
		=		  bandit 	    			    =
		=	https://overthewire.org/wargames/bandit/	    =
		=============================================================



		=============================================================
		=			SSH Information			    =			
		=	Host: bandit.labs.overthewire.org  	            =
		=	Port: 2220 			    		    =
		=============================================================


		-------------------------------------------------------------  
		- 		          SSH Login  		            -
		-       ssh username@URL -p Port 		            -
		-       ssh username@IP_address -p Port 		    -
		-       ssh username@IP_address -p Port -i Private_key 	    -
		-------------------------------------------------------------


## level 0 --> level 1
	pass bandit0
	user bandit0
	flag ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If  

	command:
	cat readme

## level 1 --> level 2
	pass ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If
	user bandit1
	flag 263JGJPfgU6LtdEvgfWU1XP5yac29mFx  

	command:
	cat ./-

## level 2 --> level 3
	pass 263JGJPfgU6LtdEvgfWU1XP5yac29mFx
	user bandit2
	flag MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx  

	command:
	cat spaces\ in\ this\ filename
	or 
	cat "spaces in this filename"

## level 3 --> level 4
	pass MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx
	user bandit3
	flag 2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ  

	command:
	cd inhere
	ls -la
	cat .hidden

## level 4 --> level 5
	pass 2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ
	user bandit4
	flag 4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw  

	command:
	file ./*
	cat ./-file07

## level 5 --> level 6
	pass 4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw
	user bandit5
	flag HWasnPhtq9AVKe0dmk45nxy20cvUa6EG  

	command:
	find . -size 1033c -type f ! -executable
	
## level 6 --> level 7
	pass HWasnPhtq9AVKe0dmk45nxy20cvUa6EG
	user bandit6
	flag morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj  

	command:
	find . -size 33c -user bandit7 -group bandit6
	
## level 7 --> level 8
	pass morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj
	user bandit7
	flag dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc  

	command: cat data.txt | grep millionth

## level 8 --> level 9
	pass dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc
	user bandit8
	flag 4CKMh1JI91bUIZZPXDqGanal4xvAg0JM  

	comamnd:
	cat data.txt | sort | uniq -u
	
## level 9 --> level 10
	pass 4CKMh1JI91bUIZZPXDqGanal4xvAg0JM
	user bandit9
	flag FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey  

	command:
	strings data.txt | grep "="

## level 10 --> level 11
	pass FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey
	user bandit10
	flag dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr  

	command: 
	cat data.txt
	echo VGhlIHBhc3N3b3JkIGlzIGR0UjE3M2ZaS2IwUlJzREZTR3NnMlJXbnBOVmozcVJyCg== | base64 -d
	
## level 11 --> level 12
	pass dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr
	user bandit11
	flag 7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4  

	command: 
	cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
	
## level 12 --> level 13
	pass 7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4
	user bandit12
	flag FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn  
	
	command:
	xxd -r data.txt > binary
	file binary
	mv binary binary.gz
	gzip -d binary.gz
	bzip2 -d binary
	tar -xvf binary.tar
		
## level 13 --> level 14 
	pass FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn
	user bamdit13
	flag MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS  
	
	command: 
	ssh username@host -p 2220 -i ssh_private_key
	
## level 14 --> level 15
	pass MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS
	user bandit14	
	flag 8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo  

	command: 
	nc localhost 30000
	or telnet 10.0.1.252 30000

## level 15 --> level 16
	pass 8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo
	user user bandit15
	flag kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx  

	command: 
	ncat --ssl localhost 30001

## level 16 --> level 17
	pass kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx
	user bandit16
	flag  
	command: 
	nmap localhost -p 31000-32000 -sV
	ncat --ssl localhost 31790
	RSA Private key is provided
	
## level 17 --> level 18
	pass no pass-- use private key
	user bandit17
	flag x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO  

	command:  
	save the private key with permission 400 (read)
	ssh bandit17@bandit.labs.overthewire.org -p 2220 -i bandit17_key
	
	diff file1 file2
	or sort passwords.new  passwords.old | uniq -u
	
	cat passwords.new  | Each_Unique_Password

## level 18 --> level 19
	pass x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO
	user bandit18
	flag cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8  

	command:
	ssh -T bandit18@bandit.labs.overthewire.org -p 2220
	** -T = Disable pseudo-terminal allocation. Used to activate non-interactive terminal
	
## level 19 --> level 20
	pass cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8
	user bandit19
	flag 0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO  

	command: 
	ls -la
	** bandit20-do script runs on SUID permission
	./bandit20-do cat /etc/bandit_pass/bandit20
	
## level 20 --> level 21
	pass 0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO
	user bandit20
	flag EeoULMCra2q0dSkYj561DX7s1CpBuOBt  

	command:
	In bandit20 terminal 1: 
		nc -l localhost 1212
		
	In bandit20 terminal 2:
		./suconnect 1212
		
	In bandit20 terminal 1: 
		Password_of_bandit20
		-- password_of_bandit21 will reveal
		
## level 21 --> level 22
	pass EeoULMCra2q0dSkYj561DX7s1CpBuOBt
	user bandit21
	flag tRae0UfB9v0UzbCdn9cY0gQnds9GF58Q  

	command:  
	cd /etc/cron.d/
	cat cronjob_bandit22
	cat /usr/bin/cronjob_bandit22.sh
	cat /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv

## level 22 --> level 23
	pass tRae0UfB9v0UzbCdn9cY0gQnds9GF58Q
	user user bandit22
	flag 0Zf11ioIjMVN551jX3CmStKLYqjk54Ga  

	command:
	cd /etc/cron.d/
	cat cronjob_bandit23
	cat /usr/bin/cronjob_bandit23.sh
	myname=bandit23
	echo I am user $myname | md5sum | cut -d ' ' -f 1
	
## level 23 --> level 24
	pass 0Zf11ioIjMVN551jX3CmStKLYqjk54Ga
	user bandit23
	flag gb8KRRCsshuZXI0tUuR6ypOFjiZbf3G8  

	command:
	cd /etc/cron.d
	cat cronjob_bandit24
	cat /usr/bin/cronjob_bandit24.sh
	cd /tmp/ban11
	touch test.sh
	chmod 777 test.sh
	vim test.sh

		#!/bin/bash
		cat /etc/bandit_pass/bandit24 > /tmp/ban11/pass
		done
		
	# To exit	:wq + Enter
	
	touch pass
	chmod 777 pass
	cp test.sh /var/spool/bandit24/foo/
	cat pass
	[result comes after 60 seconds]
		
## level 24 --> level 25 
	pass gb8KRRCsshuZXI0tUuR6ypOFjiZbf3G8
	user bandit24
	flag iCi86ttT4KSNe1armKiwbQNmB3YJP3q4  

	command:
	cd /tmp
	vim shell.sh

	#!/bin/bash
	bandit24=gb8KRRCsshuZXI0tUuR6ypOFjiZbf3G8
	for pin in {0000..9999};do
		echo "$bandit24 $pin"
	done | nc localhost 30002

	chmod 777 shell.sh
	./shell.sh

## level 25 --> level 26
	pass iCi86ttT4KSNe1armKiwbQNmB3YJP3q4
	user bandit25
	flag s0773xxkk0MXfdqOfPRVr9L3jJBUOgCZ  

	command:  
	Make the terminal window small
	ssh -i bandit26.sshkey bandit26@localhost -p 2220
	Press 'v' to open VIM
		(man more --- for details)
	To disable insert mode
		press ESC
	To check current shell
		:set shell?
		press ENTER

	To change shell to Bash
		:set shell=/bin/bash
		Press ENTER

	Check the current shell again

	To run bash shell
		:shell

	To extract password
		cat /etc/bandit_pass/bandit26

## level 26 --> level 27
	pass s0773xxkk0MXfdqOfPRVr9L3jJBUOgCZ
	user bandit26
	flag upsNCc7vzaRDx6oZC6GiR6ERwe1MowGB  

	command:
	Make the terminal window small

	ssh bandit26@bandit.labs.overthewire.org -p 2220

	Press "v" to enter VIM
	:set shell?
	:set shell=/bin/bash
	:shell
	ls -la
	./bandit27-do pwd
	./bandit27-do id
	./bandit27-do cat /etc/bandit_pass/bandit27


## Possible flag locations on Git:
1. git status
2. git log 
3. git branch -a
4. git tag
--- 


## level 27 --> level 28
	pass upsNCc7vzaRDx6oZC6GiR6ERwe1MowGB
	user user bandit27
	flag Yz9IpL0sBcCeuG7m9uQFt8ZNpS4HZRcN  

	command:
	Create a /tmp/folder directory
	git clone ssh://bandit27-git@localhost:2220/home/bandit27-git/repo
		- In git clone specify the port number
	git clone pass = bandit27 password
	 
	check README file 
	
## level 28 --> level 29 
	pass Yz9IpL0sBcCeuG7m9uQFt8ZNpS4HZRcN
	user bandi28
	flag 4pT1t5DENaYuqnqvadYs1oE4QLCdjmJ7  

	command:
	git clone ssh://bandit28-git@localhost:2220/home/bandit28-git/repo
	
	check README.md
	
	git log --oneline
	
	check all git commits
	
	git show 3621de8
	
## level 29 --> level 30
	pass 4pT1t5DENaYuqnqvadYs1oE4QLCdjmJ7
	user bandit29
	flag qp30ex3VLz5MDG1n91YowTv4Q8l7CDZL  

	command:
	Create a /tmp/folder directory
	git clone ssh://bandit29-git@localhost:2220/home/bandit28-git/repo
	check README.md
	git branch -a
		(Check out all branches)
	git checkout dev
	ls 
	cat README.md
	
## level 30 --> level 31
	qp30ex3VLz5MDG1n91YowTv4Q8l7CDZL
	user bandit30
	flag fb5S2xb7bRyFmAvQYQGEqsbhVyJqhnDy  

	command:
	Create a /tmp/folder directory
	git clone ssh://bandit30-git@localhost:2220/home/bandit28-git/repo
	check README.md
	git tag
	git show secret
	
## level 31 --> level 32
	pass fb5S2xb7bRyFmAvQYQGEqsbhVyJqhnDy
	user bandit31
	flag 3O9RfhqyAlVBEZpVb6LYStshZoqoSx5K  

	command:
	Create a /tmp/folder directory
	git clone ssh://bandit31-git@localhost:2220/home/bandit28-git/repo
	check README.md
	
	echo 'May I come in?' > key.txt
	ls -la
	rm .gitignore
	git add .
	git status
	git commit -m "message"
	git log
	git branch
	git push
	
## level 32 --> level 33
	pass 3O9RfhqyAlVBEZpVb6LYStshZoqoSx5K
	user bandit32
	flag tQdtbs5D5i2vJwkO8mEyYEyTL8izoeJ0  

	command:
	$0
	cat /etc/bandit_pass/bandit33
	




