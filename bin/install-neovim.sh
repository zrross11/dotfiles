#!/bin/bash

# Install Neovim
# This script installs Neovim using the appropriate package manager

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Installing Neovim...${NC}"

# Detect OS and package manager
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  if command -v brew &> /dev/null; then
    echo -e "${GREEN}Installing Neovim via Homebrew...${NC}"
    brew install neovim
  else
    echo -e "${RED}Error: Homebrew not found. Please install Homebrew first.${NC}"
    exit 1
  fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux
  if command -v apt-get &> /dev/null; then
    echo -e "${GREEN}Installing Neovim via apt...${NC}"
    sudo apt-get update
    sudo apt-get install -y neovim
  elif command -v yum &> /dev/null; then
    echo -e "${GREEN}Installing Neovim via yum...${NC}"
    sudo yum install -y neovim
  elif command -v dnf &> /dev/null; then
    echo -e "${GREEN}Installing Neovim via dnf...${NC}"
    sudo dnf install -y neovim
  elif command -v pacman &> /dev/null; then
    echo -e "${GREEN}Installing Neovim via pacman...${NC}"
    sudo pacman -S --noconfirm neovim
  else
    echo -e "${RED}Error: No supported package manager found (apt, yum, dnf, pacman).${NC}"
    echo -e "${YELLOW}Please install Neovim manually:${NC}"
    echo -e "${BLUE}  Visit: https://github.com/neovim/neovim/releases${NC}"
    exit 1
  fi
else
  echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
  echo -e "${YELLOW}Please install Neovim manually:${NC}"
  echo -e "${BLUE}  Visit: https://github.com/neovim/neovim/releases${NC}"
  exit 1
fi

# Verify installation
if command -v nvim &> /dev/null; then
  echo -e "${GREEN}Neovim installed successfully!${NC}"
  nvim --version | head -1
else
  echo -e "${RED}Failed to install Neovim.${NC}"
  exit 1
fi