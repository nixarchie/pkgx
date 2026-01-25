#!/usr/bin/env sh
set -eu

DIR="$(dirname "$0")"
. "$DIR/../lib/backend.sh"
. "$DIR/../lib/common.sh"   # for show_done and die
. "$DIR/../lib/config.sh"   # to load backend, DIRECT, GUM, etc.

# ---- call backend ----
# backend_add now respects DIRECT internally, so just pass packages
backend_sync
