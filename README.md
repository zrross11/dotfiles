# Dotfiles

Personal dotfiles with Starship prompt. Works on macOS (zsh) and Linux (bash).

## Quick Start

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
source ~/.zshrc  # or ~/.bashrc
```

## Structure

```
dotfiles/
├── .zshrc / .bashrc      # Main shell configs
├── starship.toml          # Starship prompt config
├── shell/                 # Shell-specific configs
│   ├── zsh/              # zsh files (macOS)
│   └── bash/             # bash files (Linux)
├── bin/                   # Binary installation scripts
└── install.sh            # Installation script
```

## Configuration

### Custom Settings

- **Machine-specific config:** Add to `~/.local/bin/env` (auto-sourced)
- **New shell modules:** Add files to `shell/zsh/` or `shell/bash/`
- **Binary installers:** Add scripts to `bin/`

## What's Included

- Starship prompt with git, kubernetes, nvim installed
- kubectl alias (`k`)
- Third-party integrations (Kiro, etc.)

## Requirements

**Required:**
- zsh (macOS) or bash (Linux)
- Homebrew (macOS)
- Starship (auto-installed by install script)
- kubectl (auto-installed by install script)
- Neovim (auto-installed by install script)
