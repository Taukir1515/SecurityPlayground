## Scope
Nuclei is used to send requests across targets based on a template, leading to zero false positives and providing fast scanning on a large number of hosts. Nuclei offers scanning for a variety of protocols, including TCP, DNS, HTTP, SSL, File, Whois, Websocket, Headless, Code etc. With powerful and flexible templating, Nuclei can be used to model all kinds of security checks.

We have a [dedicated repository](https://github.com/projectdiscovery/nuclei-templates) that houses various type of vulnerability templates contributed by **more than 300** security researchers and engineers.

## Source
```
https://github.com/projectdiscovery/nuclei
```
#### Environment:  Go

## Installation
```
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
```

```
cp /root/go/bin/nuclei /usr/local/go/bin/
```

## Updating Templates
Once the environment variables are set, following command to download the custom templates:
```
nuclei -update-templates
```
This command will clone the repository containing the custom templates to the default nuclei templates directory (`$HOME/nuclei-templates/github/`).

## Example Usages

### Help
```
nuclei -h
```
### Scanning with Nuclei Templates
Scanning target domain with [community-curated](https://github.com/projectdiscovery/nuclei-templates) nuclei templates.
As default, all the templates (except nuclei-ignore list) get executed from the default template installation path.
```
nuclei -u https://example.com
```

### Scanning a list of targets with Nuclei Templates
Scanning target URLs with [community-curated](https://github.com/projectdiscovery/nuclei-templates) nuclei templates.
Similarly, Templates can be executed against a list of URLs.
```
nuclei -list urls.txt
```

### Custom template directory or multiple template directory can be executed as follows:
```
nuclei -u https://example.com -t cves/ -t exposures/
```

### Custom template Github repos are downloaded under `github` directory. Custom repo templates can be passed as follows:
```
nuclei -u https://example.com -t github/private-repo
```

