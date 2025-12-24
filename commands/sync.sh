#!/usr/bin/env sh
set -eu

DIR="$(dirname "$0")"
. "$DIR/../lib/backend.sh"

backend_sync
show_done