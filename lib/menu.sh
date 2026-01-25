#!/usr/bin/env bash
set -eu

DIR="$(dirname "$0")"
. "$DIR/../lib/common.sh"
. "$DIR/../lib/config.sh"
. "$DIR/../lib/backend.sh"

# ---- menu only works if GUM is true ----
[ "$GUM" = true ] || die "pkgx: menu requires gum=true"

# ---- ensure fzf exists ----
command -v fzf >/dev/null 2>&1 || die "pkgx: fzf is required for the menu"

MENU_DIR="$LIB/menu"

# ---- shared fzf args ----
fzf_args=(
    --multi
    --preview 'pacman -Sii {1}'
    --preview-label='alt-p: toggle description, alt-j/k: scroll, tab: multi-select'
    --preview-label-pos='bottom'
    --preview-window 'down:65%:wrap'
    --bind 'alt-p:toggle-preview'
    --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
    --bind 'alt-k:preview-up,alt-j:preview-down'
    --color 'marker:green'
)

# ---- show main menu ----
menu_main() {
    printf "%s\n" add rm sync list | \
        fzf "${fzf_args[@]}" --header="Select an action"
}

# ---- dispatch selection ----
menu_dispatch() {
    choice="$(menu_main)"
    [ -n "$choice" ] || exit 0

    script="$MENU_DIR/$choice.sh"
    [ -f "$script" ] || die "pkgx: menu script not found: $script"

    # Run selected menu script
    exec "$script"
}

# ---- exported entrypoint ----
pkgx_menu() {
    menu_dispatch
}

# ---- always run ----
pkgx_menu
