# The installer lists the selected dotfiles in load order.
while IFS= read -r _dotfiles_module; do
  [ -z "$_dotfiles_module" ] || source "$HOME/$_dotfiles_module"
done < "$HOME/.profile-modules"
unset _dotfiles_module
