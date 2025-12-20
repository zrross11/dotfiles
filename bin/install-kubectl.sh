#!/bin/bash

# Install kubectl
# This script installs kubectl using the appropriate method for the OS

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Installing kubectl...${NC}"

# Detect OS and install method
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  if command -v brew &> /dev/null; then
    echo -e "${GREEN}Installing kubectl via Homebrew...${NC}"
    brew install kubectl
  else
    echo -e "${YELLOW}Homebrew not found. Installing kubectl via curl...${NC}"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
  fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux
  if command -v apt-get &> /dev/null; then
    echo -e "${GREEN}Installing kubectl via apt...${NC}"
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-get install -y kubectl
  elif command -v yum &> /dev/null || command -v dnf &> /dev/null; then
    echo -e "${GREEN}Installing kubectl via yum/dnf...${NC}"
    if command -v dnf &> /dev/null; then
      sudo dnf install -y kubectl
    else
      sudo yum install -y kubectl
    fi
  else
    echo -e "${YELLOW}No supported package manager found. Installing kubectl via curl...${NC}"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
  fi
else
  echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
  exit 1
fi

if command -v kubectl &> /dev/null; then
  echo -e "${GREEN}kubectl installed successfully!${NC}"
  kubectl version --client
else
  echo -e "${RED}Failed to install kubectl.${NC}"
  exit 1
fi

