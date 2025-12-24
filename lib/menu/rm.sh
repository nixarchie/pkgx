#!/usr/bin/env bash
set -eu

LIB="$(cd "$(dirname "$0")/.." && pwd)"

. "$LIB/common.sh"
. "$LIB/backend.sh"

backend="$(detect_backend)"

case "$backend" in
  pacman) pkgs="$(pacman -Qq | fzf "${fzf_args[@]}" --multi)" ;;
  freebsd) pkgs="$(pkg query "%n" | fzf "${fzf_args[@]}" --multi)" ;;
  apt) pkgs="$(apt-mark showmanual | fzf "${fzf_args[@]}" --multi)" ;;
  nix) pkgs="$(nix profile list | awk '{print $2}' | fzf "${fzf_args[@]}" --multi)" ;;
esac

[ -n "$pkgs" ] || exit 0
backend_rm $pkgs
