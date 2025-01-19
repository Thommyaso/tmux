#!/bin/bash

SESSION=$1
TARGET_WINDOW="terminal"

tmux list-panes -t "$SESSION":"$TARGET_WINDOW" -F '#{pane_id}' | while read -r pane; do

    tmux send-keys -t "$SESSION":"$TARGET_WINDOW"."$pane" Up C-m

done


