#!/bin/bash

# Dotfiles installation script for Sway on Arch Linux
# This script installs necessary packages and sets up the dotfiles

# Keep sudo alive
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install required packages
echo "Installing required packages..."
sudo pacman -S --needed --noconfirm \
    waybar \
    starship \
    tmux \
    neovim \
    git \
    ttf-jetbrains-mono-nerd \
    alsa-utils \
    pulseaudio \
    upower \
    brightnessctl \
    playerctl  # for mpris

# Symlink configuration files
echo "Setting up configuration files..."
DOTFILES_DIR="$(pwd)"

# tmux
ln -sf "$DOTFILES_DIR/tmux/tmux.conf" ~/.tmux.conf

# waybar
mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/waybar" ~/.config/

# starship
ln -sf "$DOTFILES_DIR/starship.toml" ~/.config/

# nvim (if not empty)
if [ -d "$DOTFILES_DIR/nvim" ] && [ "$(ls -A $DOTFILES_DIR/nvim)" ]; then
    ln -sf "$DOTFILES_DIR/nvim" ~/.config/
fi

# wallpapers
mkdir -p ~/Pictures
cp -r "$DOTFILES_DIR/wallpapers" ~/Pictures/

# Install tmux plugin manager and plugins
echo "Setting up tmux plugins..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
~/.tmux/plugins/tpm/bin/install_plugins

echo "Installation complete!"
echo "Please logout and login again to apply the changes, or restart Sway with 'swaymsg exit' followed by starting Sway again."