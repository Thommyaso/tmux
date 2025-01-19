#!/bin/bash

_tmux_project_autocomplete() {
    # Base directory for your projects
    local PROJECTS_DIR="${HOME}/devilbox/data/www"

    # Get the current word being typed
    local cur="${COMP_WORDS[COMP_CWORD]}"

    # Generate a list of subdirectories in PROJECTS_DIR
    COMPREPLY=( $(compgen -o filenames -W "$(ls -1d ${PROJECTS_DIR}/*/ | xargs -n 1 basename)" -- "$cur") )
}

# Register the completion function for your script
complete -F _tmux_project_autocomplete work

