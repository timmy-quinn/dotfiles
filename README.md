# Setup 
### Windows installation
Open a powershell terminal as an adminstrator

```
winget install --id Git.Git -e --source winget

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\setup.ps1
```


I've also started playing around with Cygwin.
I've found that you may need to install git with the installer rather than 
apt-cyg. Bear this in mind. SentinelOne may cause issues with git 
cloning. 


# JIRA cli  
repo: ````https://github.com/ankitpokhrel/jira-cli````

```powershell
# Setup api token
[System.Environment]::SetEnvironmentVariable('JIRA_API_TOKEN', "api_toke_from_jira", [System.EnvironmentVariableTarget]::User)
jira init
# Select type: 'cloud'
# Enter server: https://companyname.atlassian.net
```

Completion: 
```
jira completion --help
```
