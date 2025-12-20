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

# Enable colors across all tools
# macOS: CLICOLOR enables colors for BSD tools (ls, grep, etc.)
# Linux: Most tools auto-detect color support via TERM
if [[ "$OSTYPE" == "darwin"* ]]; then
  export CLICOLOR=1
  # Use a well-known LSCOLORS preset (directories=blue, executables=red)
  export LSCOLORS="ExGxBxdxCxDxDxhbhdacEc"
  alias ls="ls -G"
  # For GNU tools if installed via Homebrew
  export LS_COLORS="di=1;34:ln=1;36:so=1;35:pi=1;33:ex=1;31:bd=1;33:cd=1;33:su=1;31:sg=1;31:tw=1;34:ow=1;34"
else
  # Linux: Use dircolors if available, otherwise use standard colors
  if command -v dircolors &> /dev/null; then
    eval "$(dircolors -b)"
  else
    export LS_COLORS="di=1;34:ln=1;36:so=1;35:pi=1;33:ex=1;31:bd=1;33:cd=1;33:su=1;31:sg=1;31:tw=1;34:ow=1;34"
  fi
  alias ls="ls --color=auto"
fi

# Enable colored grep output
export GREP_COLOR='1;31'
alias grep="grep --color=auto"

# Enable colored less output
export LESS='-R'

