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
    "build-essentials"
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


# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.6/install.sh | bash

# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install 24

# Verify the Node.js version:
# node -v # Should print "v24.19.0".

# Verify npm version:
# npm -v # Should print "11.17.0".

ln ./NVim-Config ~/.config/nvim/
ln ./wezterm/.wezterm.lua ~/.config/wezterm/wezterm.lua
