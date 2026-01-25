#!/usr/bin/env sh

cat <<'EOF'
pkgx — simple package orchestration

USAGE:
  pkgx <command> [args...]

COMMANDS:
  add, install <pkg...>     Install one or more packages
  rm, remove <pkg...>      Remove one or more packages
  sync                     Sync package databases
  list                     List installed packages (requires fzf)
  aur <pkg...>             Install AUR packages (Arch only)
  menu                     Interactive TUI (requires fzf)
  config get <key>         Show config value
  help                     Show this help message

CONFIG:
  /etc/pkgx/config.yaml            System-wide defaults
  ~/.config/pkgx/config.yaml       User overrides

EXAMPLES:
  pkgx add neovim git
  pkgx aur google-chrome
  pkgx config get pm
EOF

