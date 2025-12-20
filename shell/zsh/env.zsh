# Environment variables and secrets
# This file is gitignored - create it locally for sensitive data

if [ -f "$HOME/.local/bin/env" ]; then
  source "$HOME/.local/bin/env"
fi

# GitHub token (if using gh CLI)
if command -v gh &> /dev/null; then
  export GITHUB_TOKEN=$(gh auth token 2>/dev/null || echo "")
fi
