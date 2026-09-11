# Non-interactive login shells (including Codex) do not read .zshrc.
# Interactive shells load Node from .profile so nvm stays last on PATH.
if [[ ! -o interactive ]]; then
  [ -r "$HOME/.node-env" ] && source "$HOME/.node-env"
fi
