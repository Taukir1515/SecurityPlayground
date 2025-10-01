## Scope
GF Patterns For the following parameters grep:
- ssrf
- RCE
- Lfi
- sqli
- ssti
- idor
- url redirection
- debug_logic
- interesting Subs

## Source
```
https://github.com/1ndianl33t/Gf-Patterns
```
#### Environment:  Go

## Requirement 
go language 1.17 (go1.17) or above (latest)
```
go version
```

## Installation
Downloading/Installing the GF Tool
```
go install github.com/tomnomnom/gf@latest
```

```
git clone https://github.com/1ndianl33t/Gf-Patterns
```

Configuring the GF Tool
```
cp /root/go/bin/gf /bin/
```

```
cd Gf-Patterns
```

```
mkdir .gf
```

```
mv *.json .gf
```


## Example usages

```
cat subdomains.txt | waybackurls | sort -u >> waybackdata | gf ssrf | tee -a ssfrparams.txt
```

```
cat waybackdata | gf redirect | tee -a redirect.txt
```

