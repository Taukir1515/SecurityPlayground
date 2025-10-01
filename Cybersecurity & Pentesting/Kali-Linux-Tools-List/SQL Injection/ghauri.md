## Scope
An advanced cross-platform tool that automates the process of detecting and exploiting SQL injection security flaws

## Source
https://github.com/sqlmapproject/sqlmap

Environment:  Python

## Installation
```
git clone https://github.com/r0oth3x49/ghauri.git
```

```
cd ghauri
```

```
python3 -m pip install --upgrade -r requirements.txt
```

Run: 
```
python3 setup.py install
```
### Or
```
python3 -m pip install -e
```

## Features

- Supports the following types of injection payloads:
    - Boolean based.
    - Error Based
    - Time Based
    - Stacked Queries

- Support SQL injection for following DBMS.
    - MySQL
    - Microsoft SQL Server
    - Postgres
    - Oracle
    - Microsoft Access (only supports fingerprint for now in case of boolean-based blind)

- Supports following injection types.
    - GET/POST Based injections
    - Headers Based injections
    - Cookies Based injections
    - Multipart Form data injections
    - JSON based injections
    - SOAP/XML based injections

- support proxy option `--proxy`.
- supports parsing request from txt file: switch for that `-r file.txt`
- supports limiting data extraction for dbs/tables/columns/dump: switch `--start 1 --stop 2`
- added support for resuming of all phases.
- added support for skip urlencoding switch: `--skip-urlencode`
- added support to verify extracted characters in case of boolean/time based injections.
- added support for handling redirects on user demand.
- added support for sql-shell switch: `--sql-shell` (experimental)
- added support for fresh queries switch: `--fresh-queries`
- added switch for hostname extraction: `--hostname`
- added switch to update ghauri from github: `--update`
    - Note: ghauri has to be cloned/installed from github for this switch to work for futures updates, for older version users they have to run git pull (if installed using git) to get this update and for futures updates the update will be possible with `ghauri --update` command to get the latest version of ghauri.

## <mark style="background: #FF5582A6;">Example usages</mark>

```
ghauri -u URL [OPTIONS]
```

```
General:
  -h, --help          Shows the help.
  --version           Shows the version.
  -v VERBOSE          Verbosity level: 1-5 (default 1).
  --update            update ghauri
  --batch             Never ask for user input, use the default behavior
  --flush-session     Flush session files for current target
  --fresh-queries     Ignore query results stored in session file
  --test-filter       Select test payloads by titles (experimental)

Target:
  At least one of these options has to be provided to define the
  target(s)

  -u URL, --url URL   Target URL (e.g. 'http://www.site.com/vuln.php?id=1).
  -r REQUESTFILE      Load HTTP request from a file

Request:
  These options can be used to specify how to connect to the target URL

  -A , --user-agent   HTTP User-Agent header value
  -H , --header       Extra header (e.g. "X-Forwarded-For: 127.0.0.1")
  --host              HTTP Host header value
  --data              Data string to be sent through POST (e.g. "id=1")
  --cookie            HTTP Cookie header value (e.g. "PHPSESSID=a8d127e..")
  --referer           HTTP Referer header value
  --headers           Extra headers (e.g. "Accept-Language: fr\nETag: 123")
  --proxy             Use a proxy to connect to the target URL
  --delay             Delay in seconds between each HTTP request
  --timeout           Seconds to wait before timeout connection (default 30)
  --retries           Retries when the connection related error occurs (default 3)
  --confirm           Confirm the injected payloads.
  --skip-urlencode    Skip URL encoding of payload data
  --force-ssl         Force usage of SSL/HTTPS

Optimization:
  These options can be used to optimize the performance of ghauri

  --threads THREADS   Max number of concurrent HTTP(s) requests (default 1)

Injection:
  These options can be used to specify which parameters to test for,
  provide custom injection payloads and optional tampering scripts

  -p TESTPARAMETER    Testable parameter(s)
  --dbms DBMS         Force back-end DBMS to provided value
  --prefix            Injection payload prefix string
  --suffix            Injection payload suffix string
  --safe-chars        Skip URL encoding of specific character(s): (e.g:- --safe-chars="[]")
  --fetch-using       Fetch data using different operator(s): (e.g: --fetch-using=between/in)

Detection:
  These options can be used to customize the detection phase

  --level LEVEL       Level of tests to perform (1-3, default 1)
  --code CODE         HTTP code to match when query is evaluated to True
  --string            String to match when query is evaluated to True
  --not-string        String to match when query is evaluated to False
  --text-only         Compare pages based only on the textual content

Techniques:
  These options can be used to tweak testing of specific SQL injection
  techniques

  --technique TECH    SQL injection techniques to use (default "BEST")
  --time-sec TIMESEC  Seconds to delay the DBMS response (default 5)

Enumeration:
  These options can be used to enumerate the back-end database
  management system information, structure and data contained in the
  tables.

  -b, --banner        Retrieve DBMS banner
  --current-user      Retrieve DBMS current user
  --current-db        Retrieve DBMS current database
  --hostname          Retrieve DBMS server hostname
  --dbs               Enumerate DBMS databases
  --tables            Enumerate DBMS database tables
  --columns           Enumerate DBMS database table columns
  --dump              Dump DBMS database table entries
  -D DB               DBMS database to enumerate
  -T TBL              DBMS database tables(s) to enumerate
  -C COLS             DBMS database table column(s) to enumerate
  --start             Retrieve entries from offset for dbs/tables/columns/dump
  --stop              Retrieve entries till offset for dbs/tables/columns/dump
  --sql-shell         Prompt for an interactive SQL shell (experimental)

Example:
  ghauri -u http://www.site.com/vuln.php?id=1 --dbs
```


### Single Target with parameter
```
ghauri -u http://testphp.vulnweb.com/artists.php?artist=1 --batch
```

### Multiple target parameters in a file
```
ghauri -m urls.txt --batch
```

### Scan Level; default=1; range=1 to 3
```
ghauri -u http://testphp.vulnweb.com/artists.php?artist=1 --batch --level 2
```

### HTTP code to match when query is evaluated to True
```
ghauri -u http://testphp.vulnweb.com/artists.php?artist=1 --batch --level 2 --code 200
```

### String to match when query is evaluated to True
```
ghauri -u http://testphp.vulnweb.com/artists.php?artist=1 --batch --level 2 --string product
```

### String to match when query is evaluated to False
```
ghauri -u http://testphp.vulnweb.com/artists.php?artist=1 --batch --level 2 --not-string product
```

### Use a proxy to connect to the target URL 
```
ghauri -u http://testphp.vulnweb.com/artists.php?artist=1 --batch --proxy 127.0.0.1:8080
```



