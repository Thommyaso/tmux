#!/bin/bash

VARABLES_PATH=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

source $VARABLES_PATH/variables.sh

SESSION=$1
PROJECT_DIRECTORY=$1
CUSTOM_CONFIG=$2

if [ -n "$CUSTOM_CONFIG" ]; then
    SESSION="$SESSION-$CUSTOM_CONFIG"
fi

tmux has-session -t "=${SESSION}" 2>/dev/null

if [ $? -ne 0 ]; then
    #Start session and 'run npm run dev' 
    tmux new-session -ds "$SESSION" -n "terminal" -c "$REPO_DIR"
    tmux send-keys -t "$SESSION":'terminal'.0 "cd ./$PROJECT_DIRECTORY" C-m
    # tmux send-keys -t "$SESSION":'terminal'.0 "npm run dev" C-m

    #Create new window and open nvim
    tmux new-window -t "$SESSION" -n "$PROJECT_DIRECTORY" -c $REPO_DIR/$PROJECT_DIRECTORY
    tmux send-keys -t "$SESSION":"$PROJECT_DIRECTORY".0 "nvim ." C-m 

    #Hooks:
    # tmux set-hook -t "$SESSION" client-attached "run-shell $SCRIPT_DIR/start-process.sh $SESSION"
    # tmux set-hook -t "$SESSION" client-detached "run-shell $SCRIPT_DIR/stop-process.sh $SESSION"

    if [ -n "$CUSTOM_CONFIG" ]; then
        "$SCRIPT_DIR/custom_settings/$PROJECT_DIRECTORY/$CUSTOM_CONFIG" $SESSION
    fi
fi

tmux attach-session -t "$SESSION"

