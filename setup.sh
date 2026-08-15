#!/bin/bash

# Ensure the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or with sudo."
  exit 1
fi

# Define an array of packages you want to install
APT_PACKAGES=(
    "curl"
    "neovim"
    "ripgrep"
    "zsh"
    "npm"
    "build-essential"
)

echo "Updating package lists..."
apt-get update -y

echo "Starting package installation..."

# Install all packages in the array at once
# The -y flag automatically answers 'yes' to prompts
apt-get install -y "${APT_PACKAGES[@]}"

# Check if the installation succeeded
if [ $? -eq 0 ]; then
    echo "All packages installed successfully!"
else
    echo "Some packages failed to install. Check errors above."
fi

# TODO: for some reason this doesn't seem to work
git config --global alias.ch "checkout" 
git config --global alias.st "status"
git config --global alias.ph "push"
git config --global alias.br "branch"
git config --global alias.cm "commit -m"


# Download and install nvm and node.js:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.6/install.sh | bash
\. "$HOME/.nvm/nvm.sh" # in lieu of restarting the shell
nvm install 24 # install node.js


# setup symbolic links for local config files
ln ./NVim-Config ~/.config/nvim/
ln ./wezterm/.wezterm.lua ~/.config/wezterm/wezterm.lua

# configure wezterm to be the default 
touch ~/.config/ubuntu-xdg-terminals.list
echo "org.wezfurlong.wezterm.desktop" > ~/.config/ubuntu-xdg-terminals.list 

