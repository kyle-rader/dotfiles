Write-Host "Starting Setup..."

Write-Host "Installing scoop installer"
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression

# TODO: Install NerdFont (Inconsolata Nerd Font)
# TODO: scoop install starship (starship.rs)

$wingetApps = @(
    'Microsoft.Git'
    'Microsoft.VisualStudioCode'
    'Microsoft.VisualStudio.2022.Community'
    'Microsoft.PowerShell'
    'Microsoft.WindowsTerminal'
    'GnuPG.Gpg4win'
)

forEach ($app in $wingetApps) {
    Write-Host "Installing $app"
    winget install "$app"
}

# iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
Write-Host "Setup Done."
