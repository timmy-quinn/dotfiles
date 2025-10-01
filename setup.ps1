#Requires -RunAsAdministrator


# When adding packages to this list, be careful
# We call winget -e --id
# When --id is used, the package name is different
# For example you can do winget starship OR  winget -e --id Starship.Starshp
# So if you see a package installation instruction online, make sure you use 
# the right package name/id
$wingetPackages = @(
    "Starship.Starship",
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
    $PROFILE.CurrentUserAllHosts = ".\Profile.ps1"
    "$HOME\AppData\Local\nvim" = ".\NVim-Config"
    "$HOME\.wezterm.lua" = ".\wezterm\.wezterm.lua"
    "$HOME\AppData\Roaming\nushell" = ".\nushell"
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

$nu_theme_dir = "$HOME\nushell_theme"

git clone https://github.com/catppuccin/nushell.git $nu_theme_dir


Write-Host "Creating Symbolic Links..."
foreach ($symlink in $symlinks.GetEnumerator()) {
    Get-Item -Path $symlink.Key -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    New-Item -ItemType SymbolicLink -Path $symlink.Key -Target (Resolve-Path $symlink.Value) -Force | Out-Null
}

# Persist Environment Variables
[System.Environment]::SetEnvironmentVariable('WEZTERM_CONFIG_FILE', "$PSScriptRoot\wezterm\.wezterm.lua", [System.EnvironmentVariableTarget]::User)


# Configure git variables
git config --global alias.ch checkout
git config --global alias.st status
git config --global alias.cm "commit -m"
git config --global alias.pl pull
git config --global alias.ph push
git config --global alias.br branch 
