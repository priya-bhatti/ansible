#
# This Powershell script will download and install Cygwin and Ansible.
#
# Run from Powershell
#    Set-ExecutionPolicy bypass
#    & cygwin_ansible_1.ps1
#

$storageDir = $pwd
$cygwinHome = "c:\tools\cygwin"
$cygwinUrlRoot = "http://cygwin.com"
$getPipUrlRoot = "https://bootstrap.pypa.io"
$cygwinMirror = "http://cygwin.mirror.constant.com"
$cygwinSetupExe = "setup-x86_64.exe"
$url = "$cygwinUrlRoot/$cygwinSetupExe"
$file = "$storageDir\$cygwinSetupExe"

# Fully qualified path to Cygwin setup.exe
$cygwinSetupPath = "$storageDir\$cygwinSetupExe"

# Download Cygwin setup.exe, if it doesn't already exist
if ( ! ( Test-Path -Path $cygwinSetupPath -PathType Leaf ) ) {
    $webclient = New-Object System.Net.WebClient
    $webclient.DownloadFile($url,$file)
}

Start-Process "c:\setup-x86_64.exe" -ArgumentList "--quiet-mode --root c:\tools\cygwin --site http://cygwin.mirror.constant.com --packages `"binutils,wget,curl,gcc-fortran,gcc-g++,gcc-core,gmp,libffi-devel,libssl-devel,libgmp-devel,make,openssh,openssl,openssl-devel,python2,python3,python-crypto,python-openssl,python-paramiko,python-pip,python-setuptools,python-devel,python2-devel,python3-devel,git,nano`"" -Wait -NoNewWindow;

# Add cygwin bin dir to path
$ENV:PATH="$cygwinHome\bin;$ENV:PATH"

# Ensure pip
#Start-Process -FilePath $cygwinHome\bin\bash.exe -ArgumentList '-c', '"python -m ensurepip"' -Wait -NoNewWindow

#Start-Process -FilePath $cygwinHome\bin\bash.exe -ArgumentList '-c', """wget.exe $getPipUrlRoot/get-pip.py""" -Wait -NoNewWindow
Start-Process -FilePath $cygwinHome\bin\bash.exe -ArgumentList '-c', '"python2.7.exe get-pip.py"' -Wait -NoNewWindow

# Fix fork() errors on some systems
Start-Process -FilePath $cygwinHome\bin\dash.exe -ArgumentList '-c', '"/usr/bin/rebaseall -v"' -Wait -NoNewWindow

# Install Ansible via pip
Start-Process -FilePath $cygwinHome\bin\bash.exe -ArgumentList '-c', '"pip2.7 install ansible"' -Wait -NoNewWindow

# Upgrade pip
Start-Process -FilePath $cygwinHome\bin\bash.exe -ArgumentList '-c', '"pip install --upgrade pip"' -Wait -NoNewWindow

# Install cryptograhpy via pip
Start-Process -FilePath $cygwinHome\bin\bash.exe -ArgumentList '-c', '"pip install cryptography"' -Wait -NoNewWindow

# Install Ansible via pip
Start-Process -FilePath $cygwinHome\bin\bash.exe -ArgumentList '-c', '"pip install ansible"' -Wait -NoNewWindow

# Install PyWinRm via pip for Ansible to communicate with Windows Server
Start-Process -FilePath $cygwinHome\bin\bash.exe -ArgumentList '-c', '"pip install pywinrm"' -Wait -NoNewWindow

# Run Ansible from outside of Cygwin shell
Start-Process -FilePath $cygwinHome\bin\bash.exe -ArgumentList '-c', '"ansible --version"' -Wait -NoNewWindow
