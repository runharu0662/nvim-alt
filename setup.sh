#!/bin/bash
set -e

echo "[1/7] Updating APT packages..."
sudo apt update && sudo apt upgrade -y

echo "[2/7] Installing essential tools (curl, unzip, git)..."
sudo apt install -y curl unzip software-properties-common

echo "[3/7] Installing Neovim (latest via PPA)..."
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim

# Set Neovim to use alt config
echo 'export NVIM_APPNAME=nvim-alt' >> ~/.bashrc
export NVIM_APPNAME=nvim-alt

echo "[4/7] Installing Go and gopls..."
sudo apt install -y golang
go install golang.org/x/tools/gopls@latest
echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> ~/.bashrc
export PATH=$PATH:$(go env GOPATH)/bin

echo "[5/7] Installing clangd..."
sudo apt install -y clangd

echo "[6/7] Installing Node.js v20 and npm..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

echo "[7/7] Installing Nerd Font (JetBrainsMono)..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip -o JetBrainsMono.zip
fc-cache -fv
cd -

echo "✅ Setup complete. Restart your shell or run: source ~/.bashrc"

