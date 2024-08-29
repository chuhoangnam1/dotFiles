# Homebrew shellenv
[ -s "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# iTerm2 shell integration
[ -s "${HOME}/.iterm2_shell_integration.zsh" ] && source "${HOME}/.iterm2_shell_integration.zsh"

# OrbStack command-line tools and integration
[ -s "${HOME}/.orbstact/shell/init.zsh" ] && source "${HOME}/.orbstack/shell/init.zsh" 2>/dev/null || :


