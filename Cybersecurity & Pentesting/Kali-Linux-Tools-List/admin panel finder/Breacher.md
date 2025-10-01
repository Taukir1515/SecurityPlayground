## Scope
An advanced multithreaded admin panel finder written in Python.


## Source
```
https://github.com/s0md3v/Breacher
```

Environment: Python

## Installation
```
git clone https://github.com/s0md3v/Breacher.git
```


## Example Usages

### Check all paths with php extension
```
python breacher -u example.com --type php
```


### Check all paths with php extension with threads
```
python breacher -u example.com --type php --fast
```


### Check all paths without threads
```
python breacher -u example.com
```


### Adding a custom path. For example, if you want all paths to start with /data (example.com/data/...) you can do this:

```
python breacher -u example.com --path /data
```


## Note
When you specify an extension using `--type` option, Breacher includes paths of that extension as well as paths with no extensions like `/admin/login`



