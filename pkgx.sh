#!/bin/sh

export PKGX_LIB="$PWD"
LIB="$PKGX_LIB/lib"
CMD="$PKGX_LIB/commands"

. "$LIB/common.sh"
. "$LIB/os-detect.sh"

command="$1"
shift || true

case "$command" in
    add|install)
        exec sh "$CMD/add.sh" "$@"
        ;;
    remove|rm)
        exec sh "$CMD/remove.sh" "$@"
        ;;
    menu)
        exec sh "$CMD/menu.sh" "$@"
        ;;
    ""|help|-h|--help)
        exec sh "$CMD/help.sh" "$@"
        ;;
    list)
        exec sh "$CMD/list.sh" "$@"
        ;;
    sync)
        exec sh "$CMD/sync.sh" "$@"
        ;;
    add-aur)
        exec sh "$CMD/aur-install.sh" "$@"
        ;;
    *)
        die "unknown command: $command"
        ;;
esac
