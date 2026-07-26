### startup time debugging opening tag 
# zmodload zsh/zprof
###


# setopt extended_glob null_glob -- GET BACK TO THIS WHEN YOU LEARN ABOUT GLOBBING


### path setup
typeset -U path PATH
path=(              # optional added paths to be added here in the future
    $path
    "$HOME/.local/bin"
)
###


### android/react-native related stuff
export JAVA_HOME="/usr/lib/jvm/jdk-17.0.12" # this must be before path update!
export ANDROID_HOME="$HOME/Library/Android/sdk" # this must be before path update!
path+=(
    "$JAVA_HOME/bin"
    "$ANDROID_HOME/emulator"
    "$ANDROID_HOME/platform-tools"
    /opt/android-studio/bin
)
###


### history setup
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS # doesn't save duplicate commands to history
setopt SHARE_HISTORY
###


### fzf mode for things like reverse search etc
# none cached load (takes a little longer)
# export FZF_CTRL_R_OPTS="
#     --bind='ctrl-r:up'
#     --bind='ctrl-s:down'
# "
# eval "$(fzf --zsh)"

# Cache fzf's Zsh integration for faster startup.
# It rebuilds automatically if the cache is missing or fzf is updated.
# To force a rebuild:
# rm -f "${XDG_CACHE_HOME:-$HOME/.cache}/fzf-zsh"
# exec zsh
fzf_cache="${XDG_CACHE_HOME:-$HOME/.cache}/fzf-zsh"

if [[ ! -f "$fzf_cache" || "$(command -v fzf)" -nt "$fzf_cache" ]]; then
    mkdir -p "${fzf_cache:h}"
    fzf --zsh >| "$fzf_cache"
fi

source "$fzf_cache"
###


### vim/tmux setup
bindkey -v
KEYTIMEOUT=1
export EDITOR=nvim
export VISUAL=nvim
export TERM="tmux-256color"

# fat/skinny cursor setup, normal/insert mode
function zle-keymap-select {
    case $KEYMAP in
        viins|main)
            printf '\e[5 q'    # thin bar cursor
            ;;
        vicmd)
            printf '\e[2 q'    # solid block cursor
            ;;
    esac
}

function zle-line-init {
    zle-keymap-select
}

zle -N zle-keymap-select
zle -N zle-line-init
###


### key bindings related stuff
typeset -g -A key
key[Shift-Tab]="${terminfo[kcbt]}" # making sure shift + tab works reliably across terminals

stty -ixon # making sure ctrl + S is available to use in reverse search 
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete
# reverse search keybindings if not using fzf mode and uses vi mode:
# bindkey -M viins '^R' history-incremental-search-backward
# bindkey -M viins '^S' history-incremental-search-forward
# bindkey -M vicmd '^R' history-incremental-search-backward
# bindkey -M vicmd '^S' history-incremental-search-forward
###


### aliases
alias vim=nvim
alias la="ls -lathr"
alias nvim="/usr/local/bin/nvim-fullscreen.sh"
###


### pure prompt setup, works with manually installed repo: https://github.com/sindresorhus/pure
fpath=(
    ~/Repositories/tmux
    $HOME/.zsh/pure
    $fpath
)

zstyle ':prompt:pure:prompt:success' color green # changing arrow color to green (pure default is purple)
autoload -U promptinit; promptinit
prompt pure
###


### completion
zstyle :compinstall filename '/home/thomas/.zshrc'
zstyle ':completion:*' menu select
zstyle -e ':completion:*:ssh:*:hosts' hosts 'reply=(${${${(M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*\**})' # making sure that /etc/hosts doesnt clutter autocomplete for ssh
zstyle ':completion:*:ssh:*' users off # making sure that users doesnt clutter autocomplete for ssh

# Uses cached Zsh completion data for faster shell startup. After changing completion plugins or $fpath: rm -f ~/.zcompdump* && exec zsh
# autoload -Uz compinit
# compinit -C

#This does a full rebuild only when the dump is older than 6 hours. Otherwise it uses the cached dump without rechecking everything. So that terminal is ready quicker
autoload -Uz compinit

zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"

if [[ -n "$zcompdump"(#qN.mh+6) ]]; then
    compinit
else
    compinit -C
fi
###


### nvm  setup
# non lazy nvm load - will slow down the start
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# lazy load nvm instead to improve speed of terminal startup
export NVM_DIR="$HOME/.nvm"

load-nvm() {
    unset -f nvm node npm npx yarn pnpm load-nvm

    [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
}

nvm() {
    load-nvm
    nvm "$@"
}

node() {
    load-nvm
    node "$@"
}

npm() {
    load-nvm
    npm "$@"
}

npx() {
    load-nvm
    npx "$@"
}

yarn() {
    load-nvm
    yarn "$@"
}

pnpm() {
    load-nvm
    pnpm "$@"
}
###


### Hyprland autostart
if uwsm check may-start -q; then
    exec uwsm start hyprland.desktop
fi
###


### zsh has 'bye' command that quits terminal, my bye command is a system shutdown and i like it more
disable bye
###


### startup time debugging closing tag
# zprof
###
