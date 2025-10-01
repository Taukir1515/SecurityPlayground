## Scope
Crawling and spidering framework

## Source
```
https://github.com/projectdiscovery/katana
```

Environment:  Go

## Installation

```
go install github.com/projectdiscovery/katana/cmd/katana@latest
```
#### OR

```
git clone https://github.com/projectdiscovery/katana.git
```

```
cp /root/go/bin/katana /usr/local/go/bin/
```
## Usage

#### Help 
```
katana -h
```

#### URL Input
```
katana -u https://tesla.com
```

#### Multiple URL Input (comma-separated)
```
katana -u https://tesla.com,https://google.com
```

#### List Input
```
cat url_list.txt
```

```
katana -list url_list.txt
```

#### STDIN (piped) Input
```
echo https://tesla.com | katana
```

```
cat domains | httpx | katana
```

#### Proxy to Burp Suite

```
katana -u abc.com -proxy http://127.0.0.1:8080
```
