#!/bin/bash

NVIM_PROCES=$(tmux list-panes -F "#{pane_current_command}" | grep "nvim")

if [[ -n "$NVIM_PROCES" ]]; then
    # set pane to 1/3 of window height: tmux resize-pane -y "$(tmux display-message -p "#{window_height}" | awk '{print int($1/3)}')"
    tmux resize-pane -y 15
fi
