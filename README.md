# Overview
IOC scanning across an Active Directory domain using powershell remoting with yara to detect an IOC.

This gets all domain computers and runs a yara.exe scan matching the pattern in fin1.yara.  Runs over powershell remoting.

1. Update the yara executables, if necessary
2. Adapt the fin1.yara to your custom IOCs
3. Run the script on a Domain Joined system
4. Run it as Domain Administrator
5. Ensure all target domain joined computers have WinRM/powershell remoting enabled
