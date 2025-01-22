#!/bin/bash

VARABLES_PATH=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

source $VARABLES_PATH/variables.sh

_tmux_project_autocomplete() {
    #Compleate 1st parameter (project name) based on what projects are in directory set in $REPO_DIR variable inside variables.sh:
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local BASE_DIRECTORY="${COMP_WORDS[1]}"
    local SCRIPTS_DIR="$SCRIPT_DIR/custom_settings/$BASE_DIRECTORY"

    COMPREPLY=( $(compgen -o filenames -W "$(ls -1d ${REPO_DIR}/*/ | xargs -n 1 basename)" -- "$cur") )
    ###

    # Complete 2nd parameter (custom_settings), based on what custom settings have been configured for that
    # project in custom_settings/<project-directory> location:
    if [[ ${COMP_CWORD} -eq 2 ]]; then
        COMPREPLY=( $(compgen -o filenames -W "$(ls -1d ${SCRIPTS_DIR}/* | xargs -n 1 basename)" -- "$cur") )
    fi
    ###
}

complete -F _tmux_project_autocomplete work

