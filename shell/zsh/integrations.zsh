# Third-party integrations

# zsh-autosuggestions
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Kiro shell integration
if [[ "$TERM_PROGRAM" == "kiro" ]] && command -v kiro &> /dev/null; then
  kiro_integration_path=$(kiro --locate-shell-integration-path zsh 2>/dev/null)
  if [ -n "$kiro_integration_path" ] && [ -f "$kiro_integration_path" ]; then
    source "$kiro_integration_path"
  fi
fi

