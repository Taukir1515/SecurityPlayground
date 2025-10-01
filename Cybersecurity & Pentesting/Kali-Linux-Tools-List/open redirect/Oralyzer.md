## Scope
Oralyzer, is a simple Python script that probes for Open Redirection vulnerability in a website. It does that by fuzzing the URL that is provided in the input.

## Features
Oralyzer can identify following types of Open Redirect Vulnerabilities:
- Header Based
- JavaScript Based
- Meta Tag Based  

Also, Oralyzer has its own module to fetch URLs from web.archive.org, it then separates the URLs that have specific parameters in them, parameters that are more likely to be vulnerable.


## Source
```
https://github.com/r0075h3ll/Oralyzer
```
Environment:  Python

## Installation
```
git clone https://github.com/r0075h3ll/Oralyzer.git
```

```
cd Oralyzer 
```

```
pip3 install -r requirements.txt
```


## Example Usages

#### Help
```
python oralyzer.py -h
```

#### Single Target
```
python3 oralyzer.py -u http://abc.com/redir.php?url=xyz.com
```

#### Multiple Targets
```
python3 oralyzer.py -l urls.txt
```


#### Scan for CRLF Injection
```
python3 oralyzer.py -u http://abc.com/redir.php?url=  -crlf
```

#### Using custom payload list

*Can't be used with -crlf flag*
```
python3 oralyzer.py -u http://abc.com/redir.php?url=  -p payloads.txt
```

#### Using Proxy

In order to use it, replace the default proxy url with your proxy url in core/others.py file *
```
python3 oralyzer.py -u http://abc.com/redir.php?url=  --proxy
```


#### Fetch URLs from web.archive.org

```
python3 oralyzer.py -u http://abc.com/redir.php?url=  --wayback
```
