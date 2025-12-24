#!/usr/bin/env bash

#fzf_args=(
#  --multi
#  --preview 'pacman -Sii {1}'
#  --preview-label='alt-p: toggle description, alt-j/k: scroll, tab: multi-select'
#  --preview-label-pos='bottom'
#  --preview-window 'down:65%:wrap'
#  --bind 'alt-p:toggle-preview'
#  --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
#  --bind 'alt-k:preview-up,alt-j:preview-down'
#  --color 'pointer:green,marker:green'
#)

#pkg_names=$(pacman -Slq | fzf "${fzf_args[@]}")

#if [[ -n "$pkg_names" ]]; then
#  # Convert newline-separated selections to space-separated for yay
#  echo "$pkg_names" | tr '\n' ' ' | xargs sudo pacman -S --noconfirm
#  show-done
#fi

#!/usr/bin/env sh
set -eu

DIR="$(dirname "$0")"
ROOT="$(cd "$DIR/.." && pwd)"

. "$ROOT/lib/backend.sh"

profile="${1:-}"
[ -n "$profile" ] || die "usage: pkgx install <profile>"

file="$ROOT/profiles/$profile.pkgs"
[ -f "$file" ] || die "profile not found: $profile"

pkgs="$(grep -Ev '^\s*#|^\s*$' "$file")"
[ -n "$pkgs" ] || die "profile '$profile' is empty"

backend_add $pkgs
show_done