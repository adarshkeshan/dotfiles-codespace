
#!/bin/bash

# Exit on error
set -e

# Set TERM to xterm-256color for Codespace compatibility
echo 'export TERM=xterm-256color' >> ~/.bashrc
source ~/.bashrc

sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install neovim


sudo apt update
sudo apt install -y imagemagick ghostscript tectonic nodejs npm
npm i -g @mermaid-js/mermaid-cli || true

# (optional) chromium for Mermaid on headless systems
sudo apt install -y chromium-browser || sudo apt install -y chromium || true
if command -v chromium-browser >/dev/null 2>&1; then
  echo 'export PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser' >> ~/.bashrc
elif command -v chromium >/dev/null 2>&1; then
  echo 'export PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium' >> ~/.bashrc
fi

git clone https://github.com/LazyVim/starter ~/.config/nvim

sudo apt update && sudo apt install ruby ruby-dev
sudo gem install tmuxinator
