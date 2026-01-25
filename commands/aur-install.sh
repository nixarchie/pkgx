#!/bin/sh

[ "$backend" = "pacman" ] || exit 1

set -- -S --needed "$@"
[ "$DIRECT" = true ] && set -- "$@" --noconfirm

yay "$@"

[ "$GUM" = true ] && . "$LIB/backend.sh" && show_done
