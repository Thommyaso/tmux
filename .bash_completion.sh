#!/bin/bash

_tmux_project_autocomplete() {
    #Compleate 1st parameter (project name) based on what projects are in '/devilbox/data/www' directory:
    local PROJECTS_DIR="${HOME}/devilbox/data/www"
    local cur="${COMP_WORDS[COMP_CWORD]}"

    COMPREPLY=( $(compgen -o filenames -W "$(ls -1d ${PROJECTS_DIR}/*/ | xargs -n 1 basename)" -- "$cur") )

    # Complete 2nd parameter (custom_settings), based on what custom settings have been configured for that
    # project in custom_settings/<project-directory> location:
    local current prev

    current="${COMP_WORDS[COMP_CWORD]}" # Current word being completed
    prev="${COMP_WORDS[COMP_CWORD-1]}"  # Previous word
    BASE_DIRECTORY="${COMP_WORDS[1]}"

  if [[ ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "$(ls custom_settings/$BASE_DIRECTORY)" -- "$current"))
  fi
}

complete -F _tmux_project_autocomplete work

