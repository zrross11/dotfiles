# Dotfiles

Personal dotfiles with Starship prompt and Kubernetes support. Works on macOS (zsh) and Linux (bash).

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

### Kubernetes Context Display

Toggle Kubernetes context/namespace in the Starship prompt:

**Option 1:** Edit `shell/zsh/config.zsh` (tracked in git)
```bash
export DOTFILES_SHOW_KUBE_CONTEXT=0  # 0 = hide, 1 = show (default)
```

**Option 2:** Add to `~/.local/bin/env` (not tracked, machine-specific)
```bash
export DOTFILES_SHOW_KUBE_CONTEXT=0
```

Reload: `source ~/.zshrc`

### Custom Settings

- **Machine-specific config:** Add to `~/.local/bin/env` (auto-sourced)
- **New shell modules:** Add files to `shell/zsh/` or `shell/bash/`
- **Binary installers:** Add scripts to `bin/`

## What's Included

- Starship prompt with git, kubernetes, and more
- kubectl alias (`k`)
- PATH management (krew, local bin)
- Third-party integrations (Kiro, etc.)

## Requirements

**Required:**
- zsh (macOS) or bash (Linux)
- Homebrew (macOS)
- Starship (auto-installed by install script)
- kubectl (auto-installed by install script)
- Neovim (auto-installed by install script)
