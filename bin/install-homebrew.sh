#!/bin/bash

# Install Homebrew on macOS
# This script installs Homebrew if it's not already installed

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

if [[ "$OSTYPE" != "darwin"* ]]; then
  echo -e "${YELLOW}Homebrew is macOS-only. Skipping installation.${NC}"
  exit 0
fi

if command -v brew &> /dev/null; then
  echo -e "${GREEN}Homebrew is already installed${NC}"
  exit 0
fi

echo -e "${BLUE}Installing Homebrew...${NC}"
echo -e "${YELLOW}This will run the official Homebrew installer.${NC}"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if command -v brew &> /dev/null; then
  echo -e "${GREEN}Homebrew installed successfully!${NC}"
else
  echo -e "${RED}Homebrew installation may have completed, but 'brew' command not found.${NC}"
  echo -e "${YELLOW}You may need to add Homebrew to your PATH.${NC}"
  echo -e "${BLUE}Try running: eval \"\$(/opt/homebrew/bin/brew shellenv)\"${NC}"
  exit 1
fi

