
#!/bin/bash

# Exit on error
set -e

# Set TERM to xterm-256color for Codespace compatibility
echo 'export TERM=xterm-256color' >> ~/.bashrc
source ~/.bashrc

# Define paths for scripts and configs
DOTFILES_DIR="./"
DEPS_SCRIPT="$DOTFILES_DIR/install_lazyvim_deps.sh"
NVIM_CONFIG="$DOTFILES_DIR/nvim_init.lua"
TMUX_CONFIG="$DOTFILES_DIR/tmux.conf"

# Create dotfiles directory if it doesn't exist
mkdir -p "$DOTFILES_DIR"

# Check if dependency installation script exists
if [ -f "$DEPS_SCRIPT" ]; then
  echo "Running dependency installation script..."
  bash "$DEPS_SCRIPT"
else
  echo "Error: $DEPS_SCRIPT not found!"
  exit 1
fi

# Install Neovim configuration
if [ -f "$NVIM_CONFIG" ]; then
  echo "Setting up Neovim configuration..."
  mkdir -p ~/.config/nvim
  cp "$NVIM_CONFIG" ~/.config/nvim/init.lua
else
  echo "Error: $NVIM_CONFIG not found!"
  exit 1
fi

# Install tmux configuration
if [ -f "$TMUX_CONFIG" ]; then
  echo "Setting up tmux configuration..."
  cp "$TMUX_CONFIG" ~/.tmux.conf
  # Install tmux plugin manager (TPM)
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true
else
  echo "Error: $TMUX_CONFIG not found!"
  exit 1
fi

# Sync LazyVim plugins
echo "Syncing LazyVim plugins..."
nvim --headless -c 'Lazy sync' -c 'qall'

echo "Setup complete: LazyVim with TypeScript and Python support, and tmux with Ctrl-a prefix installed."
echo "Run 'tmux' to start a session, then 'nvim' to start Neovim."
echo "Ensure your terminal uses a Nerd Font (e.g., JetBrains Mono) for icons."

