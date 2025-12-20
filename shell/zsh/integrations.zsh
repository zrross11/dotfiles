# Third-party integrations

# Kiro shell integration
if [[ "$TERM_PROGRAM" == "kiro" ]] && command -v kiro &> /dev/null; then
  kiro_integration_path=$(kiro --locate-shell-integration-path zsh 2>/dev/null)
  if [ -n "$kiro_integration_path" ] && [ -f "$kiro_integration_path" ]; then
    source "$kiro_integration_path"
  fi
fi

