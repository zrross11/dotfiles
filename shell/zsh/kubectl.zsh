# kubectl configuration and aliases

alias k=kubectl

# Optional: Add kubectl completion if available
if command -v kubectl &> /dev/null; then
  source <(kubectl completion zsh) 2>/dev/null || true
fi

