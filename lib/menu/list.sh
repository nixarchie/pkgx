#!/usr/bin/env bash
set -eu


. "$LIB/backend.sh"

backend="$(detect_backend)"

case "$backend" in
  pacman) pacman -Qe ;;
  freebsd) pkg query "%n" ;;
  apt) apt-mark showmanual ;;
  nix) nix profile list ;;
esac | fzf $FZF_ARGS
