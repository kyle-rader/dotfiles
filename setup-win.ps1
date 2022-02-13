Write-Host "Starting Setup..."

Write-Host "Installing OpenSSH Features..."
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

$wingetApps = @(
    'Microsoft.Git'
    'Microsoft.VisualStudioCode'
    'Microsoft.VisualStudio.2022.Community'
    'Microsoft.PowerShell'
    'Microsoft.WindowsTerminal'
)

forEach ($app in $wingetApps) {
    Write-Host "Installing $app"
    winget install "$app"
}

# iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
Write-Host "Setup Done."
