#Requires -RunAsAdministrator

$wingetPackages = @(
    "Chocolatey.Chocolatey --accept-source-agreements --accept-package-agreements",
    "DEVCOM.Lua"
)

$chocoPackages = @(
    "neovim",
    "wezterm",
    "ripgrep", # used by nvim Telescope
    "nodejs.install" # used by nvim Mason/Lsp
)

git config --global alias.ch checkout
git config --global alias.st status
git config --global alias.cm commit -m

foreach($package in $wingetPackages) {
    winget install -e --id $package
}

# Refresh environment to ensure choco is available
$env:Path += ";$([Sustem.Environment]::GetEnvironmentVariable('ChocolateyInstall', 'Machine'))\bin"

foreach($package in $chocoPackages) {
    choco install -y $package
}