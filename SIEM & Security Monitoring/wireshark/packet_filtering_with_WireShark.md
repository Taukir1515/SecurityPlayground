<!-- omit in toc -->
# Wireshark Packet Filtering  
<!-- omit in toc -->
## Table of Content

- [Protocol Filters](#protocol-filters)
  - [IP Filters](#ip-filters)
  - [TCP and UDP Filters](#tcp-and-udp-filters)
  - [Application Level Protocol Filters | HTTP and DNS](#application-level-protocol-filters--http-and-dns)
  - [Questions](#questions)
- [Advanced Filtering](#advanced-filtering)
  - [Filter: "contains"](#filter-contains)
  - [Filter: "matches"](#filter-matches)
  - [Filter: "in"](#filter-in)
  - [Filter: "upper"](#filter-upper)
  - [Filter: "lower"](#filter-lower)
  - [Filter: "string"](#filter-string)
  - [Questions](#questions-1)
- [Detection of Data Exfiltration through DNS Tunneling](#detection-of-data-exfiltration-through-dns-tunneling)
  - [Indicators of Attack](#indicators-of-attack)
  - [DNS Filters](#dns-filters)
  - [Questions](#questions-2)
- [Detection of Data Exfiltration through FTP](#detection-of-data-exfiltration-through-ftp)
  - [Indicators of Attack](#indicators-of-attack-1)
  - [FTP Filters](#ftp-filters)
  - [Questions](#questions-3)
- [Detection of Data Exfiltration via HTTP](#detection-of-data-exfiltration-via-http)
  - [Indicators of Attack](#indicators-of-attack-2)
  - [HTTP Filters](#http-filters)
  - [Questions](#questions-4)
- [Detection of Data Exfiltration via ICMP](#detection-of-data-exfiltration-via-icmp)
  - [Indicators of Attack](#indicators-of-attack-3)
  - [ICMP Filters](#icmp-filters)


## Protocol Filters

Wireshark supports 3000 protocols and allows packet-level investigation by filtering the protocol fields.

### IP Filters


| Filter                     | Description                                                                 |
|---------------------------|-----------------------------------------------------------------------------|
| ip                        | Show all IP packets.                                                        |
| ip.addr == 10.10.10.111   | Show all packets containing IP address 10.10.10.111.                        |
| ip.addr == 10.10.10.0/24  | Show all packets containing IP addresses from 10.10.10.0/24 subnet.        |
| ip.src == 10.10.10.111    | Show all packets originated from 10.10.10.111.                              |
| ip.dst == 10.10.10.111    | Show all packets sent to 10.10.10.111.                                      |
| ip.addr vs ip.src/ip.dst | `ip.addr` filters traffic regardless of direction, while `ip.src` and `ip.dst` filter packets based on source and destination direction.     |



### TCP and UDP Filters


| Filter Type | Filter Expression     | Description                                      |
|------------|-----------------------|--------------------------------------------------|
| TCP        | tcp.port == 80        | Show all TCP packets with port 80                |
| UDP        | udp.port == 53        | Show all UDP packets with port 53                |
| TCP        | tcp.srcport == 1234   | Show all TCP packets originating from port 1234 |
| UDP        | udp.srcport == 1234   | Show all UDP packets originating from port 1234 |
| TCP        | tcp.dstport == 80     | Show all TCP packets sent to port 80             |
| UDP        | udp.dstport == 5353   | Show all UDP packets sent to port 5353           |


### Application Level Protocol Filters | HTTP and DNS


| Protocol | Filter Expression                 | Description                               |
|----------|-----------------------------------|-------------------------------------------|
| HTTP     | http                              | Show all HTTP packets                     |
| DNS      | dns                               | Show all DNS packets                      |
| HTTP     | http.response.code == 200         | Show all HTTP responses with status 200   |
| DNS      | dns.flags.response == 0           | Show all DNS requests                     |
| HTTP     | http.request.method == "GET"      | Show all HTTP GET requests                |
| DNS      | dns.flags.response == 1           | Show all DNS responses                    |
| HTTP     | http.request.method == "POST"     | Show all HTTP POST requests               |
| DNS      | dns.qry.type == 1                 | Show all DNS "A" (IPv4) record queries    |

### Questions

> 1. What is the number of IP packets?
```
ip
```

> 2. What is the number of packets with a “TTL value less than 10”?
```
ip.ttl <= 10
```

> 3. What is the number of packets which uses “TCP port 4444”?
```
tcp.port == 4444
```

> 4. What is the number of “HTTP GET” requests sent to port “80”?
```
http.request.method == "GET" && tcp.port == 80
```

> 5. What is the number of “type A DNS Queries”?
```
dns.qry.type == 1 && dns.flags.response == 1
```

## Advanced Filtering
 

### Filter: "contains"

| Field                | Value                                                                 |
|----------------------|-----------------------------------------------------------------------|
| Filter               | contains                                                              |
| Type                 | Comparison Operator                                                    |
| Description          | Searches for a value inside packets. It is case-sensitive and works   |
|                      | similar to the **Find** option by focusing on a specific field.       |
| Example              | Find all **Apache** web servers.                                      |
| Workflow             | List all HTTP packets where the **server** field contains "Apache".  |
| Usage                | `http.server contains "Apache"`                                      |


### Filter: "matches"

| Field        | Value                                                                 |
|--------------|-----------------------------------------------------------------------|
| Filter       | matches                                                               |
| Type         | Comparison Operator                                                    |
| Description  | Searches using a **regular expression**. It is **case-insensitive**, and complex queries may have a small margin of error. |
| Example      | Find all **.php** and **.html** pages.                                |
| Workflow     | List all HTTP packets where the **host** field matches `.php` or `.html`.     |
| Usage        | `http.host matches "\.(php\|html)"`                                   |


### Filter: "in"

| Field        | Value                                                                 |
|--------------|-----------------------------------------------------------------------|
| Filter       | in                                                                    |
| Type         | Set Membership                                                        |
| Description  | Searches a value or field within a **specific set or range**.        |
| Example      | Find all packets using ports **80, 443, or 8080**.                   |
| Workflow     | List all TCP packets where the **port** field value is 80, 443, or 8080.      |
| Usage        | tcp.port in {80 443 8080}`                                          |


### Filter: "upper"

| Field        | Value                                                                 |
|--------------|-----------------------------------------------------------------------|
| Filter       | upper                                                                 |
| Type         | Function                                                              |
| Description  | Converts a string value to **uppercase**.                             |
| Example      | Find all **APACHE** web servers.                                      |
| Workflow     | Convert HTTP packets’ **server** fields to uppercase and list packets that contain the **"APACHE"** keyword.|
| Usage        | upper(http.server) contains "APACHE"                               |


### Filter: "lower"

| Field        | Value                                                                 |
|--------------|-----------------------------------------------------------------------|
| Filter       | lower                                                                 |
| Type         | Function                                                              |
| Description  | Converts a string value to **lowercase**.                             |
| Example      | Find all **apache** web servers.                                      |
| Workflow     | Convert HTTP packets’ **server** fields to lowercase and list packets that contain the **"apache"** keyword.          |
| Usage        | lower(http.server) contains "apache"                               |


### Filter: "string"

| Field        | Value                                                                 |
|--------------|-----------------------------------------------------------------------|
| Filter       | string                                                                |
| Type         | Function                                                              |
| Description  | Converts a **non-string value** into a **string**.                   |
| Example      | Find all frames with **odd frame numbers**.                          |
| Workflow     | Convert the **frame.number** field to a string and list frames that  end with odd digits.          |                                       |
| Usage        | string(frame.number) matches "[13579]$"                            |


### Questions

> 1. Find all Microsoft IIS servers. What is the number of packets that did not originate from “port 80”?
```
http.server contains "IIS" && tcp.srcport != 80
```

> 2. Find all Microsoft IIS servers. What is the number of packets that have “version 7.5”?
```
http.server contains "IIS" && http.server matches "7.5"
```

> 3. What is the total number of packets that use ports 3333, 4444 or 9999?
```
tcp.port in  {3333 4444 9999}
```

> 4. What is the number of packets with “even TTL numbers”?
```
string(ip.ttl) matches "[02468]$"
```

> 5. Change the profile to “Checksum Control”. What is the number of “Bad TCP Checksum” packets?
```
tcp.checksum.status == 0
```

## Detection of Data Exfiltration through DNS Tunneling

### Indicators of Attack

1. Many DNS queries are sent to a single external domain, especially with very high counts compared to the baseline.

2. Long subdomain labels or unusually long full query names (> 60–100 characters).

3. High entropy or Base32/Base64-like patterns in the query name (lots of mixed case letters, digits, -, = signs for base64).

4. Rare record types (TXT, NULL) or many large TXT responses.

5. Unusual response behavior: frequent NXDOMAIN (if attacker uses exfil-by-query without answering), or TCP/large UDP fragments for DNS.

6. Queries at regular intervals (beaconing behaviour).




### DNS Filters

| Analysis Goal | Wireshark Filter | Purpose |
|--------------|------------------|---------|
| Show all DNS packets | `dns` | Display all DNS traffic |
| DNS queries with no response | `dns.flags.response == 0` | Identify failed, unanswered, or suspicious DNS queries |
| Find long DNS queries | `dns && frame.len > 70` | Detect suspicious long subdomains (possible DNS tunneling) |
| Filter suspicious domain queries | `dns && dns.qry.name contains <REDACTED>` | Isolate DNS traffic related to a known suspicious domain |




### Questions

> 1. How many suspicious traffic/logs related to dns tunneling were observed?
```
dns && (dns.qry.name.len > 30)
```

> 2. Which local IP sent the maximum number of suspicious requests?

```
dns && (dns.qry.name.len > 30)
```

After using the above filter,

    a. Go to Statistics → Conversations

    b. Open the IPv4 tab

    c. Click Apply display filter (IMPORTANT)
    - This ensures only the filtered suspicious DNS traffic is counted

    d. Sort by:
      - Packets (or Bytes) column

    e. Look at the Source Address
      - The IP with the highest packet count is the answer


## Detection of Data Exfiltration through FTP

### Indicators of Attack

- `USER` and `PASS` commands (cleartext credentials).

- `STOR` (upload) and `RETR` (download) commands: repeated or large transfers.

- Large data connections to unusual external IPs, especially outside business hours.
  
- Data channel openings on temporary ports (PASV) paired with large payloads.


### FTP Filters

| Analysis Goal | Wireshark Filter | Action | Purpose |
|--------------|------------------|--------|---------|
| Filter FTP packets | `ftp or ftp-data` | — | Display FTP control and data traffic |
| Identify FTP login credentials | `ftp.request.command == "USER" or ftp.request.command == "PASS"` | Right-click packet → Follow → TCP Stream | Detect plaintext username and password transmission |
| Detect file upload activity | `ftp contains "STOR"` | Right-click packet → Follow → TCP Stream | Identify files being uploaded to the FTP server |
| Detect file download activity | `ftp contains "RETR"` | Right-click packet → Follow → TCP Stream | Identify files being downloaded from the FTP server |
| Identify large FTP data transfers | `ftp && frame.len > 90` | Right-click packet → Follow → TCP Stream | Spot suspicious or bulk data exfiltration |


### Questions

> 1. How many connections were observed from the guest account?

```
ftp contains "guest"
```

> 2. Apply the filter; what is the name of the customer-related file exfiltrated from the root account?

```
(ftp contains "STOR") && (ftp.request.arg == "root")
```

> 3. Which internal IP was found to be sending the largest payload to an external IP?

```
(ftp) && (frame.len > 90)
```

> 4. What is the flag hidden inside the ftp stream transferring the CSV file to the suspicious IP?

```
ftp contains "csv"
```
- Right-click packet → Follow → TCP Stream


## Detection of Data Exfiltration via HTTP

### Indicators of Attack


- Unusually large HTTP POST requests to external/unexpected hosts.
- HTTP requests to domains with low reputation / rarely seen in baseline traffic.
- Frequent small requests (beaconing) to the same host, followed by large uploads.
- Chunked or multipart transfers where multiple requests compose a larger file.

### HTTP Filters


| Analysis Goal | Wireshark Filter | Purpose |
|--------------|------------------|---------|
| Show all HTTP traffic | `http` | Display all HTTP packets |
| Filter HTTP POST requests | `http.request.method == "POST"` | Identify data-sending requests |
| Large HTTP POST requests | `http.request.method == "POST" && frame.len > 500` | Detect possible data exfiltration or suspicious uploads |


### Questions

> 1. Which internal compromised host was used to exfiltrate this sensitive data?

```
(http) && (frame.len > 700)
```

> 2. What's the flag hidden inside the exfiltrated data?

```
(http) && (frame.len > 700)
```
- Right-click packet → Follow → HTTP Stream


## Detection of Data Exfiltration via ICMP 

### Indicators of Attack


- ICMP packet volumes: a single host sending many ICMP echo requests to an external IP.
- Large frame.len or icmp.payload: pings with payloads much larger than typical (e.g., > 64 bytes). 
- ICMP type/code unusual values: e.g., unusual use of timestamp(13/14) or custom codes.
- Regular timing (periodicity): evenly spaced ICMP packets carrying similar-sized payloads.
- Fragments with reassembly: multiple ICMP fragments from the same src/dst pair.


### ICMP Filters


| Analysis Goal | Wireshark Filter | Purpose |
|--------------|------------------|---------|
| Show all ICMP traffic | `icmp` | Display all ICMP packets |
| Isolate ICMP Echo Requests | `icmp.type == 8` | Identify ping (echo request) activity |
| Detect large ICMP Echo Requests | `icmp.type == 8 && frame.len > 100` | Identify suspicious ICMP payloads or possible tunneling |








