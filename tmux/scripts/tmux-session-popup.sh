#!/bin/bash

# Get a list of tmux sessions
sessions=$(tmux list-sessions -F "#{session_name}")

# Use fzf to select a session
selected_session=$(echo "$sessions" | fzf --height=50 --reverse --border --prompt="Select tmux session: ")

# If a session was selected, attach to it
if [ -n "$selected_session" ]; then
    tmux switch-client -t "$selected_session"
fi

# Add the below keybind in tmux.conf
# bind-key s run-shell "tmux popup -E '$HOME/dotfiles/scripts/tmux/tmux-session-popup.sh'"
