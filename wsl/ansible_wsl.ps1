# Open Powershell in Admin mode
# Enable developer mode:
cd C:\windows\system32
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"
# Enable Windows Subsystem for Linux and Reboot if prompted:
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

# After reboot:
cd C:
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFile Ubuntu.appx -UseBasicParsing
Add-AppxPackage .\Ubuntu.appx

# run appx
explorer.exe shell:AppsFolder\$(get-appxpackage -name CanonicalGroupLimited.Ubuntu16.04onWindows | select -expandproperty CanonicalGroupLimited.Ubuntu16.04onWindows_79rhkp1fndgsc)!App

# Run Ubuntu bash shell
# complete install steps prompted
# Update disto:

# check your version: should be 16.04
# lsb_release -d
# Update to Ubuntu 18.04
# sudo do-release-upgrade -d
# Restart if prompted

# Ansible install:
# sudo apt update && apt upgrade -y
# sudo apt-get -y install python-pip python-dev libffi-dev libssl-dev
# sudo pip install ansible
# sudo pip install pywinrm
# ansible --version
