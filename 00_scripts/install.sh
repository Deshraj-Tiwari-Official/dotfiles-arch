#!/bin/bash

mkdir -p ~/Downloads ~/Pictures/Screenshots ~/Music ~/Videos

# Yay (AUR helper) setup
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay
fi

# Install necessary dependencies and other packages
yay -S --noconfirm \
    git curl wget p7zip tar rsync aria2 unzip stow btop zoxide fzf \
    bat ripgrep tmux eza hyprlock hyprpicker hypridle pavucontrol \
    brightnessctl power-profiles-daemon xdg-desktop-portal-wlr neovim zsh \
    kitty hyprland dunst waybar wofi lz4 cargo fastfetch coreutils \
    atuin gum starship yazi nerdfetch sesh lazygit yarn base-devel\
    bitwarden zen-browser-bin obsidian syncthing bluetuith mpd rmpc mpc\
    wezterm clipman glow python-pywal less


# Clone tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install bat theme
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --build
echo "--theme=\"Catppuccin Mocha\"" >> ~/.config/bat/config

# Install Homebrew (Linuxbrew) -- Commented because AUR has everything
# curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | /bin/bash
# echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Set up Flatpak -- Commented because AUR has everything
# sudo pacman -S --noconfirm flatpak
# flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
# sudo flatpak override --filesystem=$HOME/.icons

# Install fonts and icons
mkdir -p ~/.fonts ~/.icons
tar -xvf ~/dotfiles/00_scripts/assets/fonts.tar.xz -C ~/.fonts/
tar -xvf ~/dotfiles/00_scripts/assets/Banana-Dracula.tar.xz -C ~/.icons
fc-cache -fv

# Enable bluetooth
sudo systemctl enable --now bluetooth
systemctl status bluetooth

# Music services mpd and mpc
systemctl --user enable --now mpd
mkdir -p ~/.config/mpd/playlists
touch ~/.config/mpd/database ~/.config/mpd/state ~/.config/mpd/sticker.sql ~/.config/mpd/pid ~/.config/mpd/log
mpc update
mpc add "/"

# Use stow to symlink dotfiles
cd ~/dotfiles
sudo rm -rf ~/.zshrc
stow -v -t ~ zsh wezterm
stow .

# Run post-setup script
~/dotfiles/00_scripts/post.sh
