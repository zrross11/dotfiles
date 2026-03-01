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
  export LS_COLORS="di=34:ln=35:ex=32:bd=34;36:cd=34;36:su=30;41:sg=30;46:tw=30;42:ow=30;43:*.tar=31:*.tgz=31:*.zip=31:*.z=33:*.gz=33:*.bz2=33:*.xz=33:*.jpg=35:*.jpeg=35:*.gif=35:*.bmp=35:*.png=35:*.svg=35:*.pdf=31:*.ps=31"
fi

# Enable colored output for common tools
alias grep="grep --color=auto"
export LESS='-R'

# zsh completion colors and menu
zstyle ':completion:*' menu select
zstyle -e ':completion:*' list-colors 'reply=( "${(s.:.)LS_COLORS}" "di=34" "ln=35" "ex=32" )'