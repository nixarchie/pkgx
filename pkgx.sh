#!/bin/sh

export PKGX_LIB="/usr/local/lib/pkgx:$HOME/.local/bin"

exec sh "$PKGX_LIB/pkgx.sh" "$@"