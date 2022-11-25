export PATH=$PATH:/usr/local/go/bin

ZSH_THEME="powerlevel10k/powerlevel10k"

# CASE_SENSITIVE="true"

# DISABLE_AUTO_TITLE="true"

# ENABLE_CORRECTION="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
source $ZSH/oh-my-zsh.sh

plugins=(git z zsh-autosuggestions)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#06979c,bold"

alias j="z"
alias g="git"
alias gs="git status"
alias gg="git log --oneline --graph --decorate --all"
alias gd="git diff"

alias air='$(go env GOPATH)/bin/air'

# BIND KEY
# > showkey -a
# bindkey '^H' backward-kill-word
# bindkey '5~' kill-word