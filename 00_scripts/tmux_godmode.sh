#!/usr/bin/env bash

# Dependencies check
for cmd in tmux fzf zoxide; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Missing dependency: $cmd" >&2
    exit 1
  fi
done

# Current session detection: ONLY set if actively running inside tmux
current_session=""
if [[ -n "$TMUX" ]]; then
  current_session=$(tmux display-message -p '#S' 2>/dev/null)
fi

# 1. Fetch running sessions
raw_sessions=()
if tmux info >/dev/null 2>&1; then
  while IFS= read -r s; do
    [[ -n "$s" ]] && raw_sessions+=("$s")
  done < <(tmux list-sessions -F "#{session_name}" 2>/dev/null)
fi

# Format session list
session_entries=""
for s in "${raw_sessions[@]}"; do
  if [[ -n "$current_session" && "$s" == "$current_session" ]]; then
    session_entries+=$'[SES] '"$s (current)\n"
  else
    session_entries+=$'[SES] '"$s\n"
  fi
done

# 2. Fetch Zoxide directories, excluding any that already have an active session
zoxide_entries=""
while IFS= read -r dir; do
  [[ -z "$dir" ]] && continue
  base_name=$(basename "$dir" | tr . _)

  # Check if a session with this name is already active
  already_running=false
  for s in "${raw_sessions[@]}"; do
    if [[ "$s" == "$base_name" ]]; then
      already_running=true
      break
    fi
  done

  # Only display if not already represented in active sessions
  if [[ "$already_running" == false ]]; then
    display_dir="${dir/#$HOME/~}"
    zoxide_entries+=$'[DIR] '"$display_dir\n"
  fi
done < <(zoxide query -l 2>/dev/null)

combined_list=$(printf "%b%b" "$session_entries" "$zoxide_entries" | sed '/^[[:space:]]*$/d')

# If nothing to pick from, default to home session
if [[ -z "$combined_list" ]]; then
  if [[ -n "$TMUX" ]]; then
    exit 0
  else
    exec tmux new-session -A -s main -c "$HOME"
  fi
fi

# Run FZF: Enter to jump, Ctrl-X to delete a running session
selected=$(echo "$combined_list" | fzf \
  --reverse \
  --prompt="Workspace > " \
  --header="Enter: Jump  |  Ctrl-X: Kill Session  |  Esc: Quit" \
  --expect="ctrl-x")

key=$(head -n 1 <<< "$selected")
target_line=$(tail -n +2 <<< "$selected")

[[ -z "$target_line" ]] && exit 0

item_type=$(awk '{print $1}' <<< "$target_line")
item_val=$(awk '{print $2}' <<< "$target_line")

# Handle Session Deletion (Ctrl-X)
if [[ "$key" == "ctrl-x" ]]; then
  if [[ "$item_type" == "[SES]" ]]; then
    # If killing the active session from within tmux, switch away first
    if [[ -n "$TMUX" && "$item_val" == "$current_session" ]]; then
      fallback=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | grep -vx "$item_val" | head -n 1)
      if [[ -n "$fallback" ]]; then
        tmux switch-client -t "$fallback"
      else
        tmux new-session -ds "main" -c "$HOME"
        tmux switch-client -t "main"
      fi
    fi
    tmux kill-session -t "$item_val"
  fi
  exit 0
fi

# Handle Navigation (Enter)
if [[ "$item_type" == "[SES]" ]]; then
  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$item_val"
  else
    exec tmux attach-session -t "$item_val"
  fi
elif [[ "$item_type" == "[DIR]" ]]; then
  raw_dir=$(cut -d" " -f2- <<< "$target_line")
  dir_full="${raw_dir/#\~/$HOME}"
  session_name=$(basename "$dir_full" | tr . _)

  if ! tmux has-session -t="$session_name" 2>/dev/null; then
    tmux new-session -ds "$session_name" -c "$dir_full"
  fi

  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$session_name"
  else
    exec tmux attach-session -t "$session_name"
  fi
fi
