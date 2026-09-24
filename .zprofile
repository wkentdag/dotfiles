# Non-interactive login shells (including Codex) do not read .zshrc.
# Interactive shells load Node from .profile so nvm stays last on PATH.
if [[ ! -o interactive ]]; then
  [ -r "$HOME/.node-env" ] && source "$HOME/.node-env"
  # Codex sources .zshrc after .zprofile. Let .profile restore nvm after Homebrew.
  unset DOTFILES_NODE_ENV_LOADED
fi
