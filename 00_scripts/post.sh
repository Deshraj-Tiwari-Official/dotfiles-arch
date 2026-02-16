#!/bin/bash
sleep 2
clear

# Welcome message
gum style --border double --margin "1" --padding "1" --border-foreground 212 "Here’s the quick rundown of what just went down (and what you need to do)!"

# Change shell to Zsh
gum format --theme=dracula "# Change your shell to Zsh:"
echo "Run this command to switch:"
gum style --foreground 34 "   chsh -s /bin/zsh"
echo -e "\nReboot after that and run in your terminal:"
gum style --foreground 34 "   ~/dotfiles/00_scripts/post.sh"
echo "And we’ll pick up right here"

# Tmux setup -- Uncomment if shifted to tmux from wezterm multiplexer
# gum format --theme=dracula "# Get tmux ready:"
# echo "You’ll already be in a tmux session (thanks to .zshrc), so now just run:"
# gum style --foreground 34 "   tmux source ~/.config/tmux/tmux.conf"
# echo "Then press <Ctrl-Space-Shift-I> (leader + I) to install the tmux plugins."

# Wallpaper daemon start
gum format --theme=dracula "# Load your wallpaper daemon:"
echo "Press (Ctrl + W) to make your wallpaper daemon display the wallpaper."

# Neovim setup
gum format --theme=dracula "# Setup Neovim:"
echo "Run:"
gum style --foreground 34 "   v"
echo "Neovim (via lazy.nvim) will handle all the downloads. Once done, quit and run:"
gum style --foreground 34 "   :SupermavenUseFree"
echo "This will install the binaries, treesitter parsers, and mason LSPs."

# Git setup
gum format --theme=dracula "# Git setup:"
echo "Run:"
gum style --foreground 34 "   git config --global user.name \"(your github account username)\""
gum style --foreground 34 "   git config --global user.email \"(your github account email)\""
gum style --foreground 34 "   git config --global init.defaultBranch main"

echo "Press (Win + Y) to open keybinds using glow or just go and read your KEYBINDS.md file on github or something"

# Atuin login
gum format --theme=dracula "#  Login into atuin and then save the new key" 

# Final message
gum style --border double --margin "1" --padding "1" --border-foreground 46 "That’s it! Now reboot. Feels good, doesn’t it? XD"
