#!/bin/bash

SESSION=$1
PROJECT_DIRECTORY=$1

tmux has-session -t "devilbox" 2>/dev/null

if [ $? != 0 ]; then
    #If devilbox isn't running sart it in a background session
    tmux new-session -ds "devilbox" -n "terminal" -c ~/devilbox
    tmux send-keys -t 'devilbox':'terminal'.0 "./up.sh" C-m
fi

tmux has-session -t "$SESSION" 2>/dev/null

if [ $? != 0 ]; then
    #Start session and 'run npm run dev' 
    tmux new-session -ds "$SESSION" -n "terminal" -c ~/devilbox/data/www
    tmux send-keys -t "$SESSION":'terminal'.0 "cd ./$PROJECT_DIRECTORY" C-m
    tmux send-keys -t "$SESSION":'terminal'.0 "npm run dev" C-m

    #Create new window and open nvim
    tmux new-window -t "$SESSION" -n "$PROJECT_DIRECTORY" -c ~/devilbox/data/www/$PROJECT_DIRECTORY
    tmux send-keys -t "$SESSION":"$PROJECT_DIRECTORY".0 "nvim ." C-m 

    #Hooks:
    tmux set-hook -t "$SESSION" client-attached "run-shell ~/start-process.sh $SESSION"
    tmux set-hook -t "$SESSION" client-detached "run-shell ~/stop-process.sh $SESSION"
fi

tmux attach-session -t "$SESSION"

