#!/usr/bin/env sh

cat <<EOF
pkgx — simple package orchestration

USAGE:
  pkgx add <pkg...>
  pkgx rm <pkg...>
  pkgx sync
  pkgx list
  pkgx install <profile>
  pkgx menu <fzf tui>
EOF
