# -----------------------------
# Environment Variables & PATH
# -----------------------------
export EDITOR=nvim

# Starship Pywal (set before starship initializes)
export STARSHIP_CONFIG="$HOME/.cache/wal/starship.toml"

# Go Paths
export PATH="$PATH:/usr/local/go/bin"

# Homebrew Paths
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"

# Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# fzf Theme
export FZF_DEFAULT_OPTS="
  --color=fg:#BABBF1,fg+:#d0d0d0,bg:-1,bg+:#262626
  --color=spinner:#f5e0dc,pointer:#af5fff,marker:#87ff00
  --color=prompt:#d7005f,header:#f38ba8,info:#cba6f7
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --multi"

# -----------------------------
# Zinit Installer and Setup
# -----------------------------
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit.git "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi 

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load annexes without Turbo
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# -----------------------------
# Plugins (Order Matters
# -----------------------------
# 1. Completions must come before compinit
zinit light zsh-users/zsh-completions

# 2. fzf-tab hooks into completion
zinit light Aloxaf/fzf-tab

# 3. Initialize compinit
autoload -Uz compinit && compinit
zpcdreplay

# 4. Autosuggestions
zinit light zsh-users/zsh-autosuggestions

# 5. Syntax highlighting MUST be loaded last
zinit light zsh-users/zsh-syntax-highlighting

# Setup fzf shell integration
if command -v fzf &>/dev/null; then
    source <(fzf --zsh)
fi

# -----------------------------
# Completion Styling
# -----------------------------
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# -----------------------------
# History Configuration
# -----------------------------
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# -----------------------------
# Keybindings & Modes
# -----------------------------
set -o vi

# -----------------------------
# Functions
# -----------------------------
function yy() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
} 

# -----------------------------
# Aliases
# -----------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias l='eza -l --icons --git -a'
alias ls='eza --icons'
alias lt='eza -T --icons'
alias v='nvim'
alias fbn='nvim $(fzf -m --preview="bat --color=always {}")'

alias tmux='tmux -u'
alias tms='~/dotfiles/00_scripts/tmux_godmode.sh'
alias lg='lazygit'
alias bt='bluetuith'

# -----------------------------
# Shell Integrations
# -----------------------------
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
eval "$(atuin init zsh)"
