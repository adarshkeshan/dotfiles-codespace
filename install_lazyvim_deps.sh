
#!/bin/bash

# Exit on error
set -e

# Update package lists
sudo apt update

# Install dependencies
sudo apt install -y neovim git nodejs npm build-essential cmake gcc g++ curl ripgrep fzf fd-find fonts-jetbrains-mono

# Install TypeScript language server
sudo npm install -g typescript-language-server typescript

# Install Python language server (pyright)
pip3 install pyright

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
rm lazygit.tar.gz lazygit

# Backup existing Neovim configuration
mv ~/.config/nvim{,.bak} 2>/dev/null || true
mv ~/.local/share/nvim{,.bak} 2>/dev/null || true
mv ~/.local/state/nvim{,.bak} 2>/dev/null || true
mv ~/.cache/nvim{,.bak} 2>/dev/null || true

# Clone LazyVim starter template
rm -rf ~/.config/nvim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

echo "LazyVim dependencies installed successfully."

