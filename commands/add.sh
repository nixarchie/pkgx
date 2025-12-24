#!/usr/bin/env sh
set -eu

DIR="$(dirname "$0")"
. "$DIR/../lib/backend.sh"

[ "$#" -ge 1 ] || die "usage: pkgx add <pkg> [pkg...]"

backend_add "$@"

show_done