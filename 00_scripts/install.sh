#!/bin/bash

# Directory Structure Setup
mkdir -p ~/Downloads ~/Pictures/Screenshots ~/Music ~/Videos

# AUR Helper Installation (yay)
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay
fi

# System Packages & Applications Installation
yay -S --noconfirm \
    git curl wget p7zip tar rsync aria2 unzip stow btop zoxide fzf bat zsh\
    ripgrep tmux eza hyprlock hyprpicker hypridle pavucontrol grim slurp lz4\
    power-profiles-daemon xdg-desktop-portal-wlr xdg-desktop-portal-hyprland\
    kitty hyprland dunst waybar wofi brightnessctl cargo fastfetch coreutils\
    atuin gum starship yazi nerdfetch lazygit yarn base-devel linux-headers\
    bitwarden zen-browser-bin obsidian syncthing bluetuith mpd rmpc mpc vlc\
    wezterm clipman glow python-pywal less rofi awww cava tree-sitter neovim\
    tree-sitter-cli vlc-plugins-all obs-studio hyprsunset wf-recorder\

# Tmux Plugin Manager (TPM)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Bat syntax highlighter theme (Catppuccin Mocha)
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --build
echo "--theme=\"Catppuccin Mocha\"" >> ~/.config/bat/config

# Homebrew (Linuxbrew)
# curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | /bin/bash
# echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Flatpak Setup
# sudo pacman -S --noconfirm flatpak
# flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
# sudo flatpak override --filesystem=$HOME/.icons

# Assets Installation (Fonts & Icons)
mkdir -p ~/.fonts ~/.icons
tar -xvf ~/dotfiles/00_scripts/assets/fonts.tar.xz -C ~/.fonts/
tar -xvf ~/dotfiles/00_scripts/assets/Banana-Dracula.tar.xz -C ~/.icons
fc-cache -fv

# Bluetooth
sudo systemctl enable --now bluetooth
systemctl status bluetooth

# Music Player Daemon (MPD) & Client (MPC)
systemctl --user enable --now mpd
mkdir -p ~/.config/mpd/playlists
touch ~/.config/mpd/database ~/.config/mpd/state ~/.config/mpd/sticker.sql ~/.config/mpd/pid ~/.config/mpd/log
mpc update
mpc add "/"

# Dotfiles Deployment (GNU Stow)
cd ~/dotfiles
sudo rm -rf ~/.zshrc
stow -v -t ~ zsh wezterm
stow .

#  Post-Installation Script
~/dotfiles/00_scripts/post.sh
