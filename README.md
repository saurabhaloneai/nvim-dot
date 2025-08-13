# nvim-dot

cat > README.md << 'EOF'
# My Dotfiles

Personal configuration files for development environment.

## contents

- **Neovim** (`nvim/`) - Neovim configuration with plugins and custom settings
- **Tmux** (`tmux/`) - Terminal multiplexer configuration

## Requirements

- Neovim >= 0.8
- Tmux >= 3.0

## Installation

1. Clone this repository:
```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/.dotfiles
cd ~/.nvim-dot files

2. Run the install script:

./install.sh

3. Install Neovim plugins (if using a plugin manager like Packer/Lazy):

nvim --headless -c 'PackerInstall' -c 'qa'
# or for Lazy.nvim users:
nvim --headless -c 'Lazy! sync' -c 'qa'


