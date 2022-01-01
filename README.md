# ActiveDirectoryInstallation
Active Directory Installation Script

This powershell script requires two arguments as follows:

Domain
DSRM password

Once these arguments are passed, it’ll take few minutes and the forest will be installed and a reboot will reflect the changes automatically.

### Usage: 
. .\Install-AD.ps1
Invoke-ADForest -DomainName rootdse.org
Enter Safe Mode Admin Password and it will take care of the installation process. 

![image](https://user-images.githubusercontent.com/46210620/147859346-e4222e53-ec03-4c13-af5d-1f5ed1744295.png)
