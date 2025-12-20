#!/bin/bash

# Install Starship prompt
# This script installs Starship using the appropriate package manager

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Installing Starship...${NC}"

# Detect OS and package manager
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  if command -v brew &> /dev/null; then
    echo -e "${GREEN}Installing Starship via Homebrew...${NC}"
    brew install starship
  else
    echo -e "${RED}Error: Homebrew not found. Please install Homebrew first.${NC}"
    exit 1
  fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux
  if command -v apt-get &> /dev/null; then
    echo -e "${GREEN}Installing Starship via apt (using official installer)...${NC}"
    sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
  elif command -v yum &> /dev/null || command -v dnf &> /dev/null; then
    echo -e "${GREEN}Installing Starship via yum/dnf (using official installer)...${NC}"
    sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
  elif command -v pacman &> /dev/null; then
    echo -e "${GREEN}Installing Starship via pacman...${NC}"
    pacman -S starship
  else
    echo -e "${YELLOW}No supported package manager found. Using official installer...${NC}"
    sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
  fi
else
  echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
  exit 1
fi

if command -v starship &> /dev/null; then
  echo -e "${GREEN}Starship installed successfully!${NC}"
else
  echo -e "${RED}Failed to install Starship.${NC}"
  exit 1
fi

