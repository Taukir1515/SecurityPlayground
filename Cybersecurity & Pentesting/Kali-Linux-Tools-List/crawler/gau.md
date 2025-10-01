## Get All URLs (GAU)

## Scope
Fetch known URLs from AlienVault's Open Threat Exchange, the Wayback Machine, and Common Crawling.

## Source
```
https://github.com/lc/gau
```

Environment:  Go

## Installation 

```
go install github.com/lc/gau/v2/cmd/gau@latest
```

### OR

```
git clone https://github.com/lc/gau.git
```

```
cd gau/cmd
```

```
sudo mv gau /usr/local/bin/
```

```
gau --version
```


## Example Usages
#### Help
```
gau -h
```
#### Single Domain
```
printf domain.com | gau
```
#### Multiple domains in a file
```
cat domains.txt | gau --threads 5
```
#### Multiple domains
```
gau yahoo.com google.com
```
#### Saving outputs
```
gau domain.com --o domain-urls.txt
```
#### Blacklisting specific extensions
```
gau domain.com --blacklist png,jpg,gif 
```
