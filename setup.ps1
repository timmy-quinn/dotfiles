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

$symlinks = @{
    "$HOME\AppData\Local\nvim" = "NVim-Config"
    "$ENV:PROGRAMFILES\WezTerm\wezterm_modules" = ".\wezterm\"
}

Set-Location $PSScriptRoot
[Environment]::CurrentDirectory = $PSScriptRoot

Write-Host "Installing packages..."
foreach($package in $wingetPackages) {
    winget install -e --id $package
}

# Refresh environment to ensure choco is available
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

foreach($package in $chocoPackages) {
    choco install -y $package
}



Write-Host "Creating Symbolic Links..."
foreach ($symlink in $symlinks.GetEnumerator()) {
    Get-Item -Path $symlink.Key -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    New-Item -ItemType SymbolicLink -Path $symlink.Key -Target (Resolve-Path $symlink.Value) -Force | Out-Null
}

# Configure git variables
git config --global alias.ch checkout
git config --global alias.st status
git config --global alias.cm "commit -m"
git config --global alias.pl pull
git config --global alias.ph push
