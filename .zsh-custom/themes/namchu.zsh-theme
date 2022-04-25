fuction collapsed_wd() {
  echo $(pwd | perl -pe '
    BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
    }; s|^$ENV{HOME}|~|g; s|/([^/.])[^/]*(?=/)|/$1|g; s|/\.([^/])[^/]*(?=/)|/.$1|g
  ')
}

function ssh_connection() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo " %{$fg_bold[red]%}(ssh)%{$reset_color%}"
  fi
}

function normal-mode () {
  echo "%{$fg_bold[green]%} [% NORMAL]% %{$reset_color%}"
}
function insert-mode () {
  echo "%{$fg_bold[red]%} [% INSERT]% %{$reset_color%}"
}

local user_color='green'; [ $UID -eq 0 ] && user_color='red'

# local datetime=[%{$fg[magenta]%}%D{%H:%M:%S}%{$reset_color%}]
local user=%{$fg_bold[$user_color]%}%n@%m%{$reset_color%}
local workingdir=[%{$fg[cyan]%}$(collapsed_wd)%{$reset_color%}]

# PROMPT='$datetime$(ssh_connection) $user [%{$fg[cyan]%}$(collapsed_wd)%{$reset_color%}]$(git_prompt_info) %(!.#.$) '
PROMPT='$user$(ssh_connection) [%{$fg[cyan]%}$(collapsed_wd)%{$reset_color%}]$(git_prompt_info) %(!.#.$) '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}git:("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"

# Update time for the prompt
# TMOUT=1
# TRAPALRM() {
#   zle reset-prompt
# }
