# Kyle's dotfiles and setup scripts

## Windows
In 2022, we can now have a good dev experience on Windows!

First, do this as an Admin
```powershell
Write-Host "Installing OpenSSH Features..."
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```

Basic Setup
```powershell
. {iwr -useb "https://raw.githubusercontent.com/kyle-rader/dotfiles/master/setup.ps1" } | iex
```

Cargo Setup
```powershell
. {iwr -useb "https://raw.githubusercontent.com/kyle-rader/dotfiles/master/cargo-installs.ps1" } | iex
```
