# Starship prompt initialization

if command -v starship &> /dev/null; then
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

