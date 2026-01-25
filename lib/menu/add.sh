#!/usr/bin/env bash
set -eu

. "$LIB/common.sh"
. "$LIB/backend.sh"
. "$LIB/config.sh"   # backend, DIRECT, GUM, fzf_args

# ---- menu functions per backend ----
menu_add_pacman() {
    pacman -Slq | fzf "${fzf_args[@]}" \
        --multi \
        --preview 'pacman -Sii {1}' \
        --preview-label='alt-p: toggle description, alt-j/k: scroll, tab: multi-select' \
        --preview-label-pos='bottom' \
        --preview-window 'down:65%:wrap' \
        --bind 'alt-p:toggle-preview' \
        --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up' \
        --bind 'alt-k:preview-up,alt-j:preview-down' \
        --color 'marker:green'
}

menu_add_freebsd() {
    pkg search -f '' | awk '{print $1}' | fzf "${fzf_args[@]}" \
        --multi \
        --preview 'pkg info {1}' \
        --preview-window 'down:65%:wrap'
}

menu_add_apt() {
    apt-cache pkgnames | fzf "${fzf_args[@]}" \
        --multi \
        --preview 'apt-cache show {1} | sed -n "1,25p"' \
        --preview-window 'down:65%:wrap'
}

menu_add_nix() {
    nix search nixpkgs . --json \
        | sed -n 's/.*"name": "\(.*\)".*/\1/p' \
        | fzf "${fzf_args[@]}" \
            --multi \
            --preview 'nix search nixpkgs {1} | sed -n "1,40p"' \
            --preview-window 'down:65%:wrap'
}

# ---- detect backend ----
backend="${backend:-$(detect_backend)}"

# ---- run backend menu ----
case "$backend" in
    pacman)  pkgs="$(menu_add_pacman)" ;;
    freebsd) pkgs="$(menu_add_freebsd)" ;;
    apt)     pkgs="$(menu_add_apt)" ;;
    nix)     pkgs="$(menu_add_nix)" ;;
    *) die "unsupported backend" ;;
esac

# ---- exit if no selection ----
[ -n "$pkgs" ] || exit 0

# ---- call backend_add, backend handles DIRECT internally ----
backend_add $pkgs
