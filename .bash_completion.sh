#!/bin/bash

SCRIPT_PATH=$(readlink -f "${BASH_SOURCE[0]}")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

_tmux_project_autocomplete() {
    #Compleate 1st parameter (project name) based on what projects are in '/devilbox/data/www' directory:
    local PROJECTS_DIR="${HOME}/devilbox/data/www"
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local BASE_DIRECTORY="${COMP_WORDS[1]}"
    local SCRIPTS_DIR="$SCRIPT_DIR/custom_settings/$BASE_DIRECTORY"

    COMPREPLY=( $(compgen -o filenames -W "$(ls -1d ${PROJECTS_DIR}/*/ | xargs -n 1 basename)" -- "$cur") )

    # Complete 2nd parameter (custom_settings), based on what custom settings have been configured for that
    # project in custom_settings/<project-directory> location:


    if [[ ${COMP_CWORD} -eq 2 ]]; then
        COMPREPLY=( $(compgen -o filenames -W "$(ls -1d ${SCRIPTS_DIR}/* | xargs -n 1 basename)" -- "$cur") )
    fi
}

complete -F _tmux_project_autocomplete work

