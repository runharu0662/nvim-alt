#!/bin/bash
set -e

echo "[1/9] Updating APT packages..."
sudo apt update && sudo apt upgrade -y

echo "[2/9] Installing essential tools (curl, unzip, git)..."
sudo apt install -y curl unzip git software-properties-common

echo "[3/9] Installing ripgrep and fd (for Telescope)..."
sudo apt install -y ripgrep fd-find
echo 'alias fd=fdfind' >> ~/.bashrc
alias fd=fdfind

echo "[4/9] Installing Neovim (latest via PPA)..."
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim

# Set Neovim to use alternate config
echo 'export NVIM_APPNAME=nvim-alt' >> ~/.bashrc
export NVIM_APPNAME=nvim-alt

echo "[5/9] Installing Go and gopls..."
sudo apt install -y golang
GOPATH=$(go env GOPATH)
echo 'export PATH=$PATH:'"$GOPATH"'/bin' >> ~/.bashrc
export PATH=$PATH:$GOPATH/bin
go install golang.org/x/tools/gopls@latest

echo "[6/9] Installing clangd, clang-format, and cpplint..."
sudo apt install -y clangd clang-format python3.12-venv

echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc
export PATH=$PATH:~/.local/bin
if pip3 install --user cpplint; then
  echo "✅ cpplint installed."
else
  echo "❌ cpplint install failed. Consider using clang-tidy as alternative."
fi

echo "[7/9] Installing Node.js v20 and npm..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

echo "[8/9] Nerd Font (JetBrainsMono) installation (optional)..."
read -p "👉 Install Nerd Font for terminal icons? (y/N): " install_font

if [[ "$install_font" =~ ^[Yy]$ ]]; then
  mkdir -p ~/.local/share/fonts
  cd ~/.local/share/fonts
  if wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip; then
    unzip -o JetBrainsMono.zip
    echo "✅ Font extracted."
    if command -v fc-cache >/dev/null 2>&1; then
      echo "🔃 Refreshing font cache..."
      fc-cache -fv
    else
      echo "⚠️ fc-cache not found. Font cache not updated."
    fi
  else
    echo "❌ Failed to download JetBrainsMono Nerd Font. Please check the URL or version."
  fi
  cd -
else
  echo "🚫 Skipping Nerd Font installation."
fi

echo "[9/9] Setup complete ✅"
echo "👉 Restart your shell or run: source ~/.bashrc"

