# Main zshrc file
# This file sources modular configuration files from the shell/zsh/ directory

# Get the directory where this .zshrc file is located
# Handle both direct files and symlinks (macOS-compatible)
ZSH_SOURCE="${(%):-%x}"
if [ -L "$ZSH_SOURCE" ]; then
  # If it's a symlink, resolve it
  LINK_TARGET="$(readlink "$ZSH_SOURCE")"
  if [ "${LINK_TARGET:0:1}" = "/" ]; then
    # Absolute symlink
    DOTFILES_DIR="$(cd "$(dirname "$LINK_TARGET")" && pwd)"
  else
    # Relative symlink - resolve relative to the symlink's directory
    DOTFILES_DIR="$(cd "$(dirname "$ZSH_SOURCE")/$(dirname "$LINK_TARGET")" && pwd)"
  fi
else
  # If it's not a symlink, use the standard method
  DOTFILES_DIR="$(cd "$(dirname "$ZSH_SOURCE")" && pwd)"
fi
export DOTFILES_DIR

# Source configuration files
for config_file in config.zsh path.zsh env.zsh kubectl.zsh integrations.zsh; do
  if [ -f "$DOTFILES_DIR/shell/zsh/$config_file" ]; then
    source "$DOTFILES_DIR/shell/zsh/$config_file"
  fi
done

# Initialize Starship prompt (must be last)
if [ -f "$DOTFILES_DIR/shell/zsh/starship.zsh" ]; then
  source "$DOTFILES_DIR/shell/zsh/starship.zsh"
fi

