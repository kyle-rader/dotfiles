Write-Host "Starting Setup..."

Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'

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
