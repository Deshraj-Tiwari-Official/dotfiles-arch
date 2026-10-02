#!/bin/bash

# Screen Initialization & Welcome Banner
sleep 2
clear

gum style --border double --margin "1" --padding "1" --border-foreground 212 "Here’s the quick rundown of what just went down (and what you need to do)!"

# Default Shell Configuration (Zsh)
gum format --theme=dracula "# Change your shell to Zsh:"
echo "Run this command to switch:"
gum style --foreground 34 "   chsh -s /bin/zsh"
echo -e "\nManually enter zsh in current session:"
gum style --foreground 34 "   zsh"

# Multiplexer Setup (Tmux)
gum format --theme=dracula "# Get tmux ready:"
echo "Create a new tmux session and source the tmux configuration file:"
gum style --foreground 34 "   tmux"
gum style --foreground 34 "   tmux source ~/.config/tmux/tmux.conf"
echo "Then press <Ctrl-Space-Shift-I> (leader + I) to install the tmux plugins."

# Wallpaper Daemon Initialization
gum format --theme=dracula "# Load your wallpaper daemon:"
echo "Press (Ctrl + W) to make your wallpaper daemon display the wallpaper."

# Editor Configuration (Neovim)
gum format --theme=dracula "# Setup Neovim:"
echo "Run:"
gum style --foreground 34 "   v"
echo "Neovim (via lazy.nvim) will handle all the downloads. Once done, quit and run:"
gum style --foreground 34 "   :SupermavenUseFree"
echo "This will install the binaries, treesitter parsers, and mason LSPs."

# Version Control Configuration (Git)
gum format --theme=dracula "# Git setup:"
echo "Run:"
gum style --foreground 34 "   git config --global user.name \"(your github account username)\""
gum style --foreground 34 "   git config --global user.email \"(your github account email)\""
gum style --foreground 34 "   git config --global init.defaultBranch main"

# Authentication, Shell History & Keybind Reference
echo "Login into bitwarden, zen browser, and login to the web services you use"
echo "Login into atuin using the credentials you have"
gum style --foreground 34 "   atuin login"
echo "Go to github, and in your profile under the developer settings section, generate a new classic token and give all permissions ngl. Copy it, and paste in some text file on your system. Whenever you will push using git / lazygit, and it prompts you to enter github username and password, you have to use this token instead of your github password."

echo "Press (Win + Y) to open keybinds using glow or just go and read your KEYBINDS.md file on github or something"

# Completion Banner
gum style --border double --margin "1" --padding "1" --border-foreground 46 "That’s it! Now reboot.""
