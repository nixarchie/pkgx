#!/usr/bin/env bash
set -eu

# Ensure fzf exists
command -v fzf >/dev/null 2>&1 || {
    echo "pkgx: fzf is required for the menu" >&2
    exit 1
}

# Menu subdir
MENU_DIR="$LIB/menu"

# Shared fzf args
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

export fzf_args

# Main menu: add / rm / sync / list
menu_main() {
    printf "%s\n" add rm sync list | \
        fzf "${fzf_args[@]}" --header="Select an action" || return 0
}

# Dispatch selection to corresponding menu script
menu_dispatch() {
    choice="$(menu_main)" || exit 0
    [ -n "$choice" ] || exit 0

    # Make sure script exists
    script="$MENU_DIR/$choice.sh"
    [ -f "$script" ] || {
        echo "pkgx: menu script not found: $script" >&2
        exit 1
    }

    # Execute the selected menu
    exec "$script"
}

# Exported entrypoint
pkgx_menu() {
    menu_dispatch
}
