## Scope
In-depth attack surface mapping and asset discovery (Both Active & Passive)

## Source
```
https://github.com/owasp-amass/amass
```
#### Environment: Go

## Installation
*Pre-built in kali 

## Example Usage

#### Help
```
amass -h
```

#### Check the version by performing the following:
```
amass -version
```

#### The most basic use of the tool for DNS records (mx, ns, IP, cname):
```
amass enum -d example.com
```

#### Typical parameters for DNS enumeration:
```
amass enum -brute -min-for-recursive 2 -d example.com
example.com (FQDN) --> node --> www.example.com (FQDN)
www.example.com (FQDN) --> a_record --> 123.456.789.01 (IPAddress)
```

### The 'enum' Subcommand

This subcommand will perform DNS enumeration and network mapping while populating the selected graph database. All the setting available in the configuration file are relevant to this subcommand. The following flags are available for configuration:

### Mode description

- **Normal**: Run enum subcommand without specifying active or passive flag will seed the enumeration from data sources and leverage DNS to validate findings and further investigate the namespaces in scope (provided domain names)
```
amass enum -d example.com
```
   
- **Active**: It will perform all of the Normal mode and reach out to the discovered assets and attempt to obtain TLS certificates, perform DNS zone transfers, use NSEC walking, and perform web crawling.
```
amass enum -active -d example.com -p 80,443,8080
```

- **Passive**: It will only obtain information from data sources and blindly accept it.
```
amass enum --passive -d example.com
```

|Flag|Description|Example|
|---|---|---|
|-active|Enable active recon methods|amass enum -active -d example.com -p 80,443,8080|
|-alts|Enable generation of altered names|amass enum -alts -d example.com|
|-aw|Path to a different wordlist file for alterations|amass enum -aw PATH -d example.com|
|-awm|"hashcat-style" wordlist masks for name alterations|amass enum -awm dev?d -d example.com|
|-bl|Blacklist of subdomain names that will not be investigated|amass enum -bl blah.example.com -d example.com|
|-blf|Path to a file providing blacklisted subdomains|amass enum -blf data/blacklist.txt -d example.com|
|-brute|Perform brute force subdomain enumeration|amass enum -brute -d example.com|
|-d|Domain names separated by commas (can be used multiple times)|amass enum -d example.com|
|-demo|Censor output to make it suitable for demonstrations|amass enum -demo -d example.com|
|-df|Path to a file providing root domain names|amass enum -df domains.txt|
|-dns-qps|Maximum number of DNS queries per second across all resolvers|amass enum -dns-qps 200 -d example.com|
|-ef|Path to a file providing data sources to exclude|amass enum -ef exclude.txt -d example.com|
|-exclude|Data source names separated by commas to be excluded|amass enum -exclude crtsh -d example.com|
|-if|Path to a file providing data sources to include|amass enum -if include.txt -d example.com|
|-iface|Provide the network interface to send traffic through|amass enum -iface en0 -d example.com|
|-include|Data source names separated by commas to be included|amass enum -include crtsh -d example.com|
|-ip|Show the IP addresses for discovered names|amass enum -ip -d example.com|
|-ipv4|Show the IPv4 addresses for discovered names|amass enum -ipv4 -d example.com|
|-ipv6|Show the IPv6 addresses for discovered names|amass enum -ipv6 -d example.com|
|-list|Print the names of all available data sources|amass enum -list|
|-log|Path to the log file where errors will be written|amass enum -log amass.log -d example.com|
|-max-depth|Maximum number of subdomain labels for brute forcing|amass enum -brute -max-depth 3 -d example.com|
|-min-for-recursive|Subdomain labels seen before recursive brute forcing (Default: 1)|amass enum -brute -min-for-recursive 3 -d example.com|
|-nf|Path to a file providing already known subdomain names (from other tools/sources)|amass enum -nf names.txt -d example.com|
|-norecursive|Turn off recursive brute forcing|amass enum -brute -norecursive -d example.com|
|-o|Path to the text output file|amass enum -o out.txt -d example.com|
|-oA|Path prefix used for naming all output files|amass enum -oA amass_scan -d example.com|
|-p|Ports separated by commas (default: 443)|amass enum -d example.com -p 443,8080|
|-passive|A purely passive mode of execution|amass enum -passive -d example.com|
|-r|IP addresses of untrusted DNS resolvers (can be used multiple times)|amass enum -r 8.8.8.8,1.1.1.1 -d example.com|
|-rf|Path to a file providing untrusted DNS resolvers|amass enum -rf data/resolvers.txt -d example.com|
|-rqps|Maximum number of DNS queries per second for each untrusted resolver|amass enum -rqps 10 -d example.com|
|-scripts|Path to a directory containing ADS scripts|amass enum -scripts PATH -d example.com|
|-timeout|Number of minutes to execute the enumeration|amass enum -timeout 30 -d example.com|
|-tr|IP addresses of trusted DNS resolvers (can be used multiple times)|amass enum -tr 8.8.8.8,1.1.1.1 -d example.com|
|-trf|Path to a file providing trusted DNS resolvers|amass enum -trf data/trusted.txt -d example.com|
|-trqps|Maximum number of DNS queries per second for each trusted resolver|amass enum -trqps 20 -d example.com|
|-v|Output status / debug / troubleshooting info|amass enum -v -d example.com|
|-w|Path to a different wordlist file for brute forcing|amass enum -brute -w wordlist.txt -d example.com|
|-wm|"hashcat-style" wordlist masks for DNS brute forcing|amass enum -brute -wm ?l?l -d example.com|
