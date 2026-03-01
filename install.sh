#!/bin/bash

# Dotfiles installation script
# This script creates symlinks from the dotfiles directory to the home directory

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${GREEN}Installing dotfiles from $DOTFILES_DIR${NC}"

# Detect shell from $SHELL environment variable (user's actual shell)
# This works even when the script itself is running in bash
if [ -n "$SHELL" ]; then
  case "$SHELL" in
    *zsh) SHELL_TYPE="zsh" ;;
    *bash) SHELL_TYPE="bash" ;;
    *)
      # Fallback: check if zsh is available (macOS default)
      if command -v zsh &> /dev/null; then
        SHELL_TYPE="zsh"
      else
        SHELL_TYPE="bash"
      fi
      ;;
  esac
else
  # Last resort: default to zsh on macOS, bash on Linux
  if [[ "$OSTYPE" == "darwin"* ]]; then
    SHELL_TYPE="zsh"
  else
    SHELL_TYPE="bash"
  fi
fi

echo -e "${BLUE}Detected shell: $SHELL_TYPE${NC}"

# Check and install Homebrew on macOS if needed
if [[ "$OSTYPE" == "darwin"* ]] && ! command -v brew &> /dev/null; then
  echo -e "${YELLOW}Homebrew not found. Installing...${NC}"
  if [ -f "$DOTFILES_DIR/bin/install-homebrew.sh" ]; then
    "$DOTFILES_DIR/bin/install-homebrew.sh"
    # Add Homebrew to PATH for current session
    if [ -f "/opt/homebrew/bin/brew" ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  else
    echo -e "${RED}Error: install-homebrew.sh not found${NC}"
    echo -e "${YELLOW}Please install Homebrew manually:${NC}"
    echo -e "${BLUE}  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"${NC}"
    exit 1
  fi
fi

# Install Starship if needed (using dedicated script)
if ! command -v starship &> /dev/null; then
  echo -e "${YELLOW}Starship not found. Installing...${NC}"
  if [ -f "$DOTFILES_DIR/bin/install-starship.sh" ]; then
    "$DOTFILES_DIR/bin/install-starship.sh"
  else
    echo -e "${RED}Error: install-starship.sh not found${NC}"
    exit 1
  fi
else
  echo -e "${GREEN}Starship is already installed${NC}"
fi

# Install kubectl if needed
if ! command -v kubectl &> /dev/null; then
  echo -e "${YELLOW}kubectl not found. Installing...${NC}"
  if [ -f "$DOTFILES_DIR/bin/install-kubectl.sh" ]; then
    "$DOTFILES_DIR/bin/install-kubectl.sh"
  else
    echo -e "${RED}Error: install-kubectl.sh not found${NC}"
    exit 1
  fi
else
  echo -e "${GREEN}kubectl is already installed${NC}"
fi

# Install Neovim if needed
if ! command -v nvim &> /dev/null; then
  echo -e "${YELLOW}Neovim not found. Installing...${NC}"
  if [ -f "$DOTFILES_DIR/bin/install-neovim.sh" ]; then
    "$DOTFILES_DIR/bin/install-neovim.sh"
  else
    echo -e "${RED}Error: install-neovim.sh not found${NC}"
    exit 1
  fi
else
  echo -e "${GREEN}Neovim is already installed${NC}"
fi

# Function to create symlink with backup
create_symlink() {
  local source="$1"
  local target="$2"
  local description="$3"

  if [ ! -e "$source" ]; then
    echo -e "${YELLOW}Warning: Source file $source does not exist, skipping${NC}"
    return
  fi

  # If target exists and is not a symlink, back it up
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo -e "${YELLOW}Backing up existing $description to ${target}.backup${NC}"
    mv "$target" "${target}.backup"
  fi

  # Create parent directory if it doesn't exist
  mkdir -p "$(dirname "$target")"

  # Create symlink (ln -sf will overwrite existing symlinks automatically)
  ln -sf "$source" "$target"
  echo -e "${GREEN}Linked $description${NC}"
}

# Install shell configuration files
if [ "$SHELL_TYPE" = "zsh" ]; then
  create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc" ".zshrc"
elif [ "$SHELL_TYPE" = "bash" ]; then
  create_symlink "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc" ".bashrc"
  # Also install .bash_profile if it doesn't exist (macOS)
  if [[ "$OSTYPE" == "darwin"* ]] && [ ! -f "$HOME/.bash_profile" ]; then
    echo -e "${BLUE}Creating .bash_profile to source .bashrc (macOS)${NC}"
    echo 'if [ -f ~/.bashrc ]; then source ~/.bashrc; fi' > "$HOME/.bash_profile"
  fi
fi

# Install starship.toml
create_symlink "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml" "starship.toml"

# Install Neovim configuration
create_symlink "$DOTFILES_DIR/nvim/init.lua" "$HOME/.config/nvim/init.lua" "Neovim config"

# Install Kitty configuration
create_symlink "$DOTFILES_DIR/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf" "Kitty config"

echo -e "${GREEN}Installation complete!${NC}"
if [ "$SHELL_TYPE" = "zsh" ]; then
  echo -e "${YELLOW}Note: You may need to restart your shell or run: source ~/.zshrc${NC}"
elif [ "$SHELL_TYPE" = "bash" ]; then
  echo -e "${YELLOW}Note: You may need to restart your shell or run: source ~/.bashrc${NC}"
fi

