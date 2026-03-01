# Starship prompt initialization

if command -v starship &> /dev/null; then
  # Use ~/.config/starship.toml (managed by install.sh symlink)
  export STARSHIP_CONFIG="$HOME/.config/starship.toml"

  # Initialize starship
  eval "$(starship init zsh)"
else
  echo "Warning: starship not found. Install it with: brew install starship" >&2
fi

