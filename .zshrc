###############################################################################
# ZSH debugging
if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi
# time ZSH_DEBUGRC=1 zsh -i -c exit


##############################################################################
# Oh-My-ZSH configuration

export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.zsh-custom

COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_TITLE="true"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="false"
HIST_STAMPS="dd/mm/yyyy"
ZSH_DISABLE_COMPFIX="true"
ZSH_THEME="namchu"

plugins=()

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
export VISUAL='nvim'

export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.UTF-8'
export LC_NUMERIC='en_US.UTF-8'
export LC_TIME='en_GB.UTF-8'
export LC_COLLATE='en_US.UTF-8'
export LC_MONETARY='en_US.UTF-8'
export LC_MESSAGES='en_US.UTF-8'
export LC_PAPER='en_US.UTF-8'
export LC_NAME='en_US.UTF-8'
export LC_ADDRESS='en_US.UTF-8'
export LC_TELEPHONE='en_US.UTF-8'
export LC_MEASUREMENT='en_US.UTF-8'
export LC_IDENTIFICATION='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

setopt no_share_history

###############################################################################
# Loading aliases
[ -s "$HOME/.zsh-aliases" ] && source "$HOME/.zsh-aliases"

###############################################################################
# Loading personal scripts
[ -s "$HOME/.zsh-personal" ] && source "$HOME/.zsh-personal"

###############################################################################
# Homebrew configuration
# if type brew &>/dev/null
# then
#   FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

#   autoload -Uz compinit
#   compinit

#   # Add homebrew executables to path
#   # export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
#   # export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
#   # export PATH="/opt/homebrew/opt/python/libexec/bin:$PATH"
#   # export PATH="/opt/homebrew/opt/postgresql@14/bin:$PATH"
# fi

###############################################################################
# Setup path for personal ~/Application/bin and ~/.local/bin
export PATH="$PATH:$HOME/Applications/bin"
export PATH="$PATH:$HOME/.local/bin"

################################################################################
## Setup nvm
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
#[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

################################################################################
## Setup rbenv
#export RBENV_ROOT="$HOME/.rbenv"
#export PATH="$RBENV_ROOT/bin:$PATH"
#[ -s "$HOME/.rbenv/bin/rbenv" ] && eval "$($HOME/.rbenv/bin/rbenv init - zsh)"

################################################################################
## Setup pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#[ -s "$PYENV_ROOT/bin/pyenv" ] && eval "$($PYENV_ROOT/bin/pyenv init - zsh)"

################################################################################
## Setup golang
#export GOPATH="$HOME/Applications/go"
#export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
#[ -s "$HOME/.gvm/scripts/gvm" ] && source "$HOME/.gvm/scripts/gvm"


###############################################################################
# Setup asdf for runtime version control
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

export ASDF_GOROOT="$HOME/.asdf/plugins/golang/set-env.zsh"
[ -s "$ASDF_GOROOT" ] && source "$ASDF_GOROOT"

###############################################################################
# ZSH debugging
if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi
###############################################################################
