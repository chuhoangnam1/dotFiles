eval "$(/opt/homebrew/bin/brew shellenv)"

###############################################################################
# Homebrew executables
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/python/libexec/bin:$PATH"

###############################################################################
# Setup nvm
alias load-nvm='source "$HOME/.nvm/nvm.sh"'
# source "$HOME/.nvm/nvm.sh"

###############################################################################
# Setup rbenv
alias load-rbenv='export PATH="$HOME/.rbenv/bin:$PATH" && eval "$(rbenv init - zsh)"'
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init - zsh)"

###############################################################################
# Setup pyenv
alias load-pyenv='export PYENV_ROOT="$HOME/.pyenv" && export PATH="$PYENV_ROOT/bin:$PATH" && eval "$(pyenv init - zsh)"'
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - zsh)"

###############################################################################
# Setup golang
# export GOPATH="$HOME/.go"
# export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
alias load-go='export GOPATH="$HOME/.go" && export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"'
