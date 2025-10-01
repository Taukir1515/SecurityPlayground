## Scope
Fast golang web crawler for gathering URLs and JavaScript file locations. This is basically a simple implementation of the awesome Gocolly library.
## Source
```
https://github.com/hakluke/hakrawler
```

Environment:  Go

## Installation

```
go install github.com/tomnomnom/waybackurls@latest
```
#### OR
```
git clone https://github.com/tomnomnom/waybackurls.git
```

```
cp /root/go/bin/waybackurls /usr/local/go/bin/
```


## Example usages

#### Help
```
waybackurls -h
```

#### Single URL
```
echo abc.com | waybackurls | tee -a urls.txt
```

#### Multiple URL
```
cat url_files.txt | waybackurls | tee -a urls.txt
```

