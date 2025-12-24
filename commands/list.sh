#!/usr/bin/env sh
set -eu

DIR="$(dirname "$0")"
. "$DIR/../lib/backend.sh"

backend="$(detect_backend)"

case "$backend" in
  pacman)
    pacman -Qe | bat
    ;;
  nix)
    nix profile list | bat 
    ;;
  freebsd)
    pkg query "%n" | bat
    ;;
  apt)
    apt-mark showmanual | bat
    ;;
esac
show_done