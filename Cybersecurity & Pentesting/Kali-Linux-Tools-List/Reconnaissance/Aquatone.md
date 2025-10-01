## Scope
Aquatone is a tool for visual inspection of websites across a large amount of hosts and is convenient for quickly gaining an overview of HTTP-based attack surface.

## Source
```
https://github.com/michenriksen/aquatone
```

### ▶ Requirement: 
Google Chrome or Chromium Browser (Chromium is recommended)  

## Installation
Aquatone — is a tool for visual inspection of websites
Instructions to Install Aquatone on Kali Linux.


#### ▶ Download the latest release of Aquatone : 
```
https://github.com/michenriksen/aquatone/releases/
```

#### ▶ Run : 
```
unzip aquatone_linux_amd64_1.7.0.zip
```

#### ▶ Run : 
```
cd aquatone_linux_amd64_1.7.0
```

#### ▶ Run : 
```
mv aquatone /usr/bin/  
```

#### ▶ Run (Check) : 
```
aquatone -version
```  

#### ▶ Run (Check/Usage) : 
```
cat list.txt | aquatone 
```
[list.txt contains the list of domains]  

▶ View : Open file manage (/root), point to the html report of aquatone and open it with any browser.

## Usage

```
cat targets.txt | aquatone
```

### Changing the output destination

If you don't want Aquatone to create files in the current working directory, you can specify a different location with the `-out` flag:
```
cat hosts.txt | aquatone -out ~/aquatone/example.com
```

### It is also possible to set a permanent default output destination by defining an environment variable:
```
export AQUATONE_OUT_PATH="~/aquatone"
```

### Specifying ports to scan

By default, Aquatone will scan target hosts with a small list of commonly used HTTP ports: 80, 443, 8000, 8080 and 8443. You can change this to your own list of ports with the `-ports` flag:
```
cat hosts.txt | aquatone -ports 80,443,3000,3001
```

### Aquatone also supports aliases of built-in port lists to make it easier for you:

- **small**: 80, 443
- **medium**: 80, 443, 8000, 8080, 8443 (same as default)
- **large**: 80, 81, 443, 591, 2082, 2087, 2095, 2096, 3000, 8000, 8001, 8008, 8080, 8083, 8443, 8834, 8888
- **xlarge**: 80, 81, 300, 443, 591, 593, 832, 981, 1010, 1311, 2082, 2087, 2095, 2096, 2480, 3000, 3128, 3333, 4243, 4567, 4711, 4712, 4993, 5000, 5104, 5108, 5800, 6543, 7000, 7396, 7474, 8000, 8001, 8008, 8014, 8042, 8069, 8080, 8081, 8088, 8090, 8091, 8118, 8123, 8172, 8222, 8243, 8280, 8281, 8333, 8443, 8500, 8834, 8880, 8888, 8983, 9000, 9043, 9060, 9080, 9090, 9091, 9200, 9443, 9800, 9981, 12443, 16080, 18091, 18092, 20720, 28017

**Example:**
```
cat hosts.txt | aquatone -ports large
```


### Amass DNS enumeration
```
amass -active -brute -o hosts.txt -d yahoo.com
```
	alerts.yahoo.com
	ads.yahoo.com
	am.yahoo.com
	- - - SNIP - - -
	prd-vipui-01.infra.corp.gq1.yahoo.com
	cp103.mail.ir2.yahoo.com
	prd-vipui-01.infra.corp.bf1.yahoo.com

```
cat hosts.txt | aquatone
```

### Nmap or Masscan

Aquatone can make a report on hosts scanned with the [Nmap](https://nmap.org/) or [Masscan](https://github.com/robertdavidgraham/masscan) portscanner. Simply feed Aquatone the XML output and give it the `-nmap` flag to tell it to parse the input as Nmap/Masscan XML:
```
$ cat scan.xml | aquatone -nmap
```

