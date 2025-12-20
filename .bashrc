# Main bashrc file
# This file sources modular configuration files from the shell/bash/ directory

# Get the directory where this .bashrc file is located
# Handle both direct files and symlinks (macOS/Linux compatible)
BASH_SOURCE="${BASH_SOURCE[0]}"
if [ -L "$BASH_SOURCE" ]; then
  # If it's a symlink, resolve it
  LINK_TARGET="$(readlink "$BASH_SOURCE")"
  if [ "${LINK_TARGET:0:1}" = "/" ]; then
    # Absolute symlink
    DOTFILES_DIR="$(cd "$(dirname "$LINK_TARGET")" && pwd)"
  else
    # Relative symlink - resolve relative to the symlink's directory
    DOTFILES_DIR="$(cd "$(dirname "$BASH_SOURCE")/$(dirname "$LINK_TARGET")" && pwd)"
  fi
else
  # If it's not a symlink, use the standard method
  DOTFILES_DIR="$(cd "$(dirname "$BASH_SOURCE")" && pwd)"
fi
export DOTFILES_DIR

# Source configuration files
for config_file in config.sh path.sh env.sh kubectl.sh integrations.sh; do
  if [ -f "$DOTFILES_DIR/shell/bash/$config_file" ]; then
    source "$DOTFILES_DIR/shell/bash/$config_file"
  fi
done

# Initialize Starship prompt (must be last)
if [ -f "$DOTFILES_DIR/shell/bash/starship.sh" ]; then
  source "$DOTFILES_DIR/shell/bash/starship.sh"
fi

