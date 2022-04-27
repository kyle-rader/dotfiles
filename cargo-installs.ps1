Write-Host "Starting cargo installs"

Write-Host "Adding Rust Clippy"
rustup component add clippy

$webInstallApps = @(
    'comrak'
    'fd'
    'jq'
    'yq'
    'pandoc'
)

foreach ($app in $webInstallApps) {
    Write-Host "Installing $app"
    curl.exe -A "MS" "https://webinstall.dev/$app" | powershell
}

$cargoInstallApps = @(
    'loki-cli'
    'bat'
    'ripgrep'
    'cargo-edit'
    'fd-find'
    'git-delta'
    'hexyl'
    'hyperfine'
    'pastel'
    'sd'
    'xh'
)

foreach ($app in $cargoInstallApps) {
    Write-Host "Installing $app"
    cargo install "$app" --locked
}

$cargoNightlyInstallApps = @(
    'dua-cli'
)

foreach ($app in $cargoNightlyInstallApps) {
    Write-Host "Installing $app"
    cargo +nightly install "$app" --locked
}
