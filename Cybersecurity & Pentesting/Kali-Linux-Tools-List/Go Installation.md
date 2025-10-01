### Start by opening your web browser and visit
```
https://golang.org/dl/
```
  
Download the latest version for Linux – _“gox.xx.x.linux-amd64.tar.gz”_  

Open your terminal and navigate to your downloads folder  
```
cd /root/Downloads
```

Extract the files  to /usr/local/ directory
```
tar -C /usr/local/ -xzf go1.13.6.linux-amd64.tar.gz
```

Go to /root/ directory.
```
cd
```

Add variables for GO by modifying _“~/.zshrc”_  
```
mousepad .zshrc
```

Add the following paths to the end of the file  
```
export PATH=$PATH:/usr/local/go/bin
```

Now we need to refresh the .zshrc to get the updated variables  
```
source .zshrc
```

Now we just need to verify that everything is correctly configured.

Just type
```
go
```  

 
If everything was configured correctly, you should see go instructions.
