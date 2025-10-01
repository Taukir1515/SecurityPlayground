## Scope
Fast subdomains enumeration tool for penetration testers

## Source
```
https://github.com/aboul3la/Sublist3r
```
#### Environment: Python

## Installation
```
git clone https://github.com/aboul3la/Sublist3r.git
```

## Example Usage

|Short Form|Long Form|Description|
|---|---|---|
|-d|--domain|Domain name to enumerate subdomains of|
|-b|--bruteforce|Enable the subbrute bruteforce module|
|-p|--ports|Scan the found subdomains against specific tcp ports|
|-v|--verbose|Enable the verbose mode and display results in realtime|
|-t|--threads|Number of threads to use for subbrute bruteforce|
|-e|--engines|Specify a comma-separated list of search engines|
|-o|--output|Save the results to text file|
|-h|--help|show the help message and exit|

- To list all the basic options and switches use -h switch:
```
python sublist3r.py -h
```

- To enumerate subdomains of specific domain:
```
python sublist3r.py -d domain.com -o save.txt
```

- To enumerate subdomains of specific domain and show only subdomains which have open ports 80 and 443 :
```
python sublist3r.py -d domain.com -p 80,443
```

- To enumerate subdomains of specific domain and show the results in real-time:
```
python sublist3r.py -v -d domain.com
```

- To enumerate subdomains and enable the brute force module:
```
python sublist3r.py -b -d domain.com
```

- To enumerate subdomains and use specific engines such Google, Yahoo and Virustotal engines
```
python sublist3r.py -e google,yahoo,virustotal -d domain.com
```

