#!/bin/bash

# nvim_process=$(tmux list-panes -F "#{pane_current_command}")
local nvim_process=false

tmux list-panes -F "#{pane_pid}" | while read pid; do
    # Find the foreground process running in the pane
    program=$(ps -o comm= --pid "$(pgrep -P "$pid" | tail -n 1)")
    if [[ "$program" =~ nvim ]]; then
        $nvim_process=true
    fi
done

if $nvim_process; then
    # set pane to 1/3 of window height: tmux resize-pane -y "$(tmux display-message -p "#{window_height}" | awk '{print int($1/3)}')"
    tmux resize-pane -y 15
fi
