# Starship prompt initialization

if command -v starship &> /dev/null; then
  # Configure kubernetes module visibility based on DOTFILES_SHOW_KUBE_CONTEXT
  # This must be set before starship init
  if [ "${DOTFILES_SHOW_KUBE_CONTEXT:-1}" = "0" ]; then
    export STARSHIP_KUBERNETES_DISABLED=true
  else
    unset STARSHIP_KUBERNETES_DISABLED
  fi

  # Set starship config location
  # DOTFILES_DIR should be set by the main shell config file
  if [ -n "$DOTFILES_DIR" ] && [ -f "$DOTFILES_DIR/starship.toml" ]; then
    export STARSHIP_CONFIG="$DOTFILES_DIR/starship.toml"
  elif [ -f "$HOME/.config/starship.toml" ]; then
    # Fallback to standard location if symlinked
    export STARSHIP_CONFIG="$HOME/.config/starship.toml"
  fi

  # Initialize starship
  eval "$(starship init zsh)"
else
  echo "Warning: starship not found. Install it with: brew install starship" >&2
fi

