#!/bin/bash

SESSION="$1"
WINDOW="$2"

if [[ "$WINDOW" != "0" ]]; then
    DIRECTORY=$( basename $(tmux display-message -p -t "${SESSION}:${WINDOW}.1" "#{pane_current_path}"))

    tmux rename-window -t "$SESSION":"$WINDOW" "$DIRECTORY"
fi
