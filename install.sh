#!/bin/bash

# This script installs necessary packages and sets up the dotfiles

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


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
    playerctl  


echo "Setting up configuration files..."
DOTFILES_DIR="$(pwd)"


ln -sf "$DOTFILES_DIR/tmux/tmux.conf" ~/.tmux.conf


mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/waybar" ~/.config/


ln -sf "$DOTFILES_DIR/starship.toml" ~/.config/


if [ -d "$DOTFILES_DIR/nvim" ] && [ "$(ls -A $DOTFILES_DIR/nvim)" ]; then
    ln -sf "$DOTFILES_DIR/nvim" ~/.config/
fi


mkdir -p ~/Pictures
cp -r "$DOTFILES_DIR/wallpapers" ~/Pictures/

#setting up plugys 
echo "Setting up tmux plugins..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
~/.tmux/plugins/tpm/bin/install_plugins

echo "Installation complete!"
echo "log out bitch"
