function yazi-pick() {
  local tmp=$(mktemp -t tmp.XXXXXX)
  local saved_path="$PATH"
  command yazi . --chooser-file "$tmp"
  export PATH="$saved_path"
  local result=""
  if [[ -s "$tmp" ]]; then
    while IFS= read -r path || [[ -n "$path" ]]; do
      [[ -z "$path" ]] && continue
      if [[ "$path" =~ ^search://[^/]+/(.+)$ ]]; then
        path="${match[1]}"
      fi
      path="${path/#$HOME/\$HOME}"
      if [[ "$path" == *'['* || "$path" == *']'* || "$path" == *'('* || "$path" == *')'* || "$path" == *' '* ]]; then
        result+="\"$path\" "
      else
        result+="$path "
      fi
    done < "$tmp"
    result="${result% }"
  fi
  command rm -f -- "$tmp" 2>/dev/null
  echo "$result"
}

function _yazi-pick-widget() {
  local result=$(yazi-pick)
  if [[ -n "$result" ]]; then
    LBUFFER+="$result"
    zle redisplay
  fi
}

zle -N _yazi-pick-widget
bindkey -r '^o'
bindkey '^o' _yazi-pick-widget


if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# CASE_SENSITIVE="true"

# DISABLE_AUTO_TITLE="true"

# ENABLE_CORRECTION="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
plugins=(git zsh-autosuggestions zsh-fzf-history-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ***********************************************************************

# CONFIGURATIONS
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#06979c,bold"

# KEYBOARD REMAPPING
# xmodmap -e "keycode 118 = Delete" # Insert -> Delete
# xmodmap -e "keycode 107 = Home" # PrtSc -> Home
# xmodmap -e "keycode 119 = End" #Delete -> End

ZSH_FZF_HISTORY_SEARCH_FZF_EXTRA_ARGS='-i'
ZSH_FZF_HISTORY_SEARCH_END_OF_LINE='yes'
# ZSH_FZF_HISTORY_SEARCH_BIND='^f'
ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0

bindkey '^H' backward-kill-word

# ALIAS
# alias j="z"
alias f="fzf"
alias g="git"
alias gc="git checkout"
alias gs="git status"
# alias gg="git log --oneline --graph --decorate --all"
alias gg="~/dotfiles/bin/gg"
alias gd="git diff"
alias scrcpy2="scrcpy --max-size 1024 --video-bit-rate 2M --shortcut-mod=rctrl --power-off-on-close --show-touches --turn-screen-off"

alias ls="eza --icons --color=always -al -snew"
alias ll="eza --icons --color=always --group-directories-first -alF"
alias l.="eza -a | egrep "^\.""

alias cd="j"
alias cdi="ji"

export LESS=eFRX
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$(go env GOPATH)/bin
export PATH="$PATH":"$HOME/.pub-cache/bin"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


function ranger {
    local IFS=$'\t\n'
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    local ranger_cmd=(
        command
        ranger
        --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
    )
    
    ${ranger_cmd[@]} "$@"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    command rm -f -- "$tempfile" 2>/dev/null
}

# bun completions
[ -s "/home/ya/.bun/_bun" ] && source "/home/ya/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$PATH:$HOME/flutter/bin"

export JAVA_HOME="$HOME/jdk"
export PATH="$JAVA_HOME/bin:$PATH"

export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_HOME/emulator"

export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/cool-bin"

eval "$(zoxide init --cmd j zsh)"
