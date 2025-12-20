# PATH configuration

export PYTHON3="/opt/homebrew/bin/python3"

# Add krew to PATH if it exists
if [ -d "${KREW_ROOT:-$HOME/.krew}/bin" ]; then
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

# Add local bin to PATH if it exists
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

