## Scope:
- httprobe takes a list of domains and **checks if they have active HTTP or HTTPS servers running**.
- It essentially pings each domain to see if there's a web server present and responding.
- This helps identify active subdomains, potential targets for further analysis, and possibly even hidden web servers.

## Source
```
https://github.com/tomnomnom/httprobe
```

Environment: Go

## Installation
```
go install github.com/tomnomnom/httprobe@latest
```

```
cp /root/go/bin/httprobe /usr/local/go/bin/
```

## Usage

```
cat domains.txt | httprobe
```

### By default httprobe checks for HTTP on port 80 and HTTPS on port 443. You can add additional probes with the `-p` flag by specifying a protocol and port pair:
```
cat domains.txt | httprobe -p http:81 -p https:8443
```

### Concurrency

#### You can set the concurrency level with the `-c` flag:
```
cat domains.txt | httprobe -c 50
```

### Timeout

#### You can change the timeout by using the `-t` flag and specifying a timeout in milliseconds:
```
cat domains.txt | httprobe -t 20000
```

### Skipping Default Probes

If you don't want to probe for HTTP on port 80 or HTTPS on port 443, you can use the `-s` flag. You'll need to specify the probes you do want using the `-p` flag:
```
cat domains.txt | httprobe -s -p https:8443
```

### Prefer HTTPS

#### Sometimes you don't care about checking HTTP if HTTPS is working. You can do that with the `--prefer-https` flag:
```
cat domains.txt | httprobe --prefer-https
```


