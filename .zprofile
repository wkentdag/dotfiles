# Non-interactive login shells (including Codex) do not read .zshrc.
# Interactive shells load the selected modules from .profile.
if [[ ! -o interactive ]]; then
  while IFS= read -r _dotfiles_module; do
    [ -z "$_dotfiles_module" ] || source "$HOME/$_dotfiles_module"
  done < "$HOME/.profile-login"
  unset _dotfiles_module
  # Codex sources .zshrc after .zprofile. Let .profile restore nvm after Homebrew.
  unset DOTFILES_NODE_ENV_LOADED
fi
