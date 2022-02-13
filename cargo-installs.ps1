Write-Host "Starting cargo installs"

Write-Host "Adding Rust Clippy"
rustup component add clippy

$webInstallApps = (
    bat
    comrak
    ripgrep
    fd
    jq
    yq
    pandoc
)

foreach ($app in $webInstallApps) {
    Write-Host "Installing $app"
    iex (curl.exe -A "MS" "https://webinstall.dev/$app")
}

$cargoInstallApps = (
    cargo-edit
    fd-find
    git-delta
    hexly
    hyperfine
    pastel
    sd
    xh
)

foreach ($app in $cargoInstallApps) {
    Write-Host "Installing $app"
    cargo install "$app" --locked
}

$cargoNightlyInstallApps = (
    dua-cli
)

foreach ($app in $cargoNightlyInstallApps) {
    Write-Host "Installing $app"
    cargo +nightly install "$app" --locked
}