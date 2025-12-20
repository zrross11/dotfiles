# Colors configuration for zsh
# This file sets up colors for ls, autocompletion, and other shell features

# Enable colors
export CLICOLOR=1

# Set colors for different platforms
if [[ "$OSTYPE" == "darwin"* ]]; then
  export LSCOLORS="ExGxBxdxCxDxDxhbhdacEc"
  alias ls="ls -G"
else
  alias ls="ls --color=auto"
fi

# Use dircolors if available, otherwise set basic colors
if command -v dircolors &> /dev/null; then
  eval "$(dircolors -b)"
else
  export LS_COLORS="di=1;34:ln=1;36:ex=1;31:*.tar=1;31:*.zip=1;31:*.jpg=1;35:*.png=1;35"
fi

# Enable colored output for common tools
alias grep="grep --color=auto"
export LESS='-R'

# zsh completion colors and menu
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select