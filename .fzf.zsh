# Setup fzf
# ---------
if [[ ! "$PATH" == */home/andyjjrt/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/andyjjrt/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/andyjjrt/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/andyjjrt/.fzf/shell/key-bindings.zsh"

# fzf configs
export FZF_COMMAND="fd -E .git -E node_modules --color=always"
export FZF_DEFAULT_COMMAND="$FZF_COMMAND --type f"
export FZF_CTRL_T_COMMAND=$FZF_COMMAND
export FZF_ALT_C_COMMAND="$FZF_COMMAND --type d"
export FZF_DEFAULT_OPTS="--ansi --reverse --border --preview='bat -n --color=always {}'"

export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

export TMUX_FZF_LAUNCH_KEY="C-f"
export FZF_TMUX_OPTS="-p -w 70% -h 50% -m"
