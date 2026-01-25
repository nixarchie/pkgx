#!/usr/bin/env sh
set -eu

DIR="$(dirname "$0")"
. "$DIR/../lib/backend.sh"
. "$DIR/../lib/common.sh"   # show_done, die
. "$DIR/../lib/config.sh"   # backend, DIRECT, GUM, etc.

# use backend from config or detect
backend="${backend:-$(detect_backend)}"

# ---- list installed packages ----
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
    *)
        die "unknown backend: $backend"
        ;;
esac | fzf
