# tmux
alias tmux="TERM=screen-256color-bce tmux"

#complete -W "$(teamocil --list)" teamocil
alias tm="tmux"
alias tmls="tmux list-sessions"

function tma() {
  if [[ $# > 0 ]]; then
    TMUX= tmux attach -t "$@"
  else
    tmux attach
  fi
}

alias tms="tmux switch -t"
alias tmk="tmux kill-session -t"

function tmns() {
  local here=$(basename $(pwd)) # | snake_case)
  if [[ $# -eq 1 ]]; then
    TMUX= tmux new-session -s "$1"
  elif [[ $# -eq 2 ]]; then
    TMUX= tmux new-session -s "$1" -c "$2"
  else
    TMUX= tmux new-session -s "$here"
  fi
}

# Autocomplete tmux sessions
# http://www.nathankowald.com/blog/2014/03/tmux-attach-session-alias/
_tmux_sessions() {
  TMUX_SESSIONS=$(tmux ls -F '#S' | xargs)

  local cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "$TMUX_SESSIONS" -- $cur) )
}

complete -F _tmux_sessions tma
complete -F _tmux_sessions tms
complete -F _tmux_sessions tmk

function tm-rename-window() {
  # This is probably really dumb and will never be used.
  local window_name=$(basename $(pwd))
  # But: "it ain't stupid if it works!"
  printf "\033k$window_name\033\\" # http://superuser.com/a/565741
}

# What the hell was this for again?
alias tmcp='cat ~/.tmux/SCRATCH_PAD | grep --color=never "panes on" | pbcopy' # stupid trick until you get this mapped
