#!/usr/bin/env bash
set -eu

# ---- determine library path ----
LIB="$(cd "$(dirname "$0")/.." && pwd)"

# ---- load helpers ----
. "$LIB/common.sh"   # show_done, die
. "$LIB/backend.sh"   # backend_* functions
. "$LIB/config.sh"    # backend, DIRECT, GUM, fzf_args

# ---- detect backend if not already set ----
backend="${backend:-$(detect_backend)}"

# ---- show installed packages and select via fzf ----
case "$backend" in
    pacman)
        pkgs="$(pacman -Qq | fzf "${fzf_args[@]}" --multi)"
        ;;
    freebsd)
        pkgs="$(pkg query "%n" | fzf "${fzf_args[@]}" --multi)"
        ;;
    apt)
        pkgs="$(apt-mark showmanual | fzf "${fzf_args[@]}" --multi)"
        ;;
    nix)
        pkgs="$(nix profile list | awk '{print $2}' | fzf "${fzf_args[@]}" --multi)"
        ;;
    *)
        die "unsupported backend: $backend"
        ;;
esac

# ---- exit if no selection ----
[ -n "$pkgs" ] || exit 0

# ---- call backend_rm, it handles DIRECT internally ----
backend_rm "$pkgs"
