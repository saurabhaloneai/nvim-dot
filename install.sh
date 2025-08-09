#!/bin/bash

# Create symbolic links for configurations

# Neovim
echo "Setting up Neovim config..."
rm -rf ~/.config/nvim
ln -sf $(pwd)/nvim ~/.config/nvim

# Tmux
echo "Setting up tmux config..."
ln -sf $(pwd)/tmux/tmux.conf ~/.tmux.conf

echo "Dotfiles installation complete!"
echo "You may need to:"
echo "1. Install your Neovim plugins"
echo "2. Reload tmux config with: tmux source-file ~/.tmux.conf"
