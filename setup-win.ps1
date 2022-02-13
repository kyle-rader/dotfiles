function Download-Winget {
    $repo = "microsoft/winget-cli"
    $file = "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

    $releases = "https://api.github.com/repos/$repo/releases"

    Write-Host Determining latest release
    $tag = (Invoke-WebRequest $releases | ConvertFrom-Json)[0].tag_name

    $download = "https://github.com/$repo/releases/download/$tag/$file"
    $name = $file.Split(".")[0]
    $zip = "$name-$tag.zip"
    $dir = "$name-$tag"

    Write-Host Dowloading latest release
    Invoke-WebRequest $download -Out $zip

    Write-Host Extracting release files
    Expand-Archive $zip -Force

    # Cleaning up target dir
    Remove-Item $name -Recurse -Force -ErrorAction SilentlyContinue 

    # Moving from temp dir to target dir
    Move-Item $dir\$name -Destination $name -Force

    # Removing temp files
    Remove-Item $zip -Force
    Remove-Item $dir -Recurse -Force
}

Write-Host "Starting Setup..."
Download-Winget()

# iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
Write-Host "Setup Done."
