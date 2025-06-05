#!/bin/bash
set -e

echo "[1/6] Updating APT packages..."
sudo apt update

echo "[2/6] Installing Neovim (latest via PPA)..."
sudo apt install -y software-properties-common curl unzip
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim

echo "[3/6] Installing Go and gopls..."
sudo apt install -y golang
go install golang.org/x/tools/gopls@latest
echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> ~/.bashrc

echo "[4/6] Installing clangd..."
sudo apt install -y clangd

echo "[5/6] Installing Node.js v20 and npm..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

echo "[6/6] Installing Nerd Font (JetBrainsMono)..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip -o JetBrainsMono.zip
fc-cache -fv
cd -

change setting

export NVIM_APPNAME=nvim-alt

echo "✅ Setup complete. You may need to restart your shell or run 'source ~/.bashrc'"

