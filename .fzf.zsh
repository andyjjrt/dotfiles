# Setup fzf
# ---------
if [[ ! "$PATH" == */home/andyjjrt/.local/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/andyjjrt/.local/fzf/bin"
fi

source <(fzf --zsh)
