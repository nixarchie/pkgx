#!/usr/bin/env sh
set -eu

DIR="$(dirname "$0")"
. "$DIR/../lib/backend.sh"

backend="$(detect_backend)"

case "$backend" in
  pacman)
    pacman -Qe
    ;;
  nix)
    nix profile list
    ;;
  freebsd)
    pkg query "%n"
    ;;
  apt)
    apt-mark showmanual
    ;;
esac | fzf

show_done