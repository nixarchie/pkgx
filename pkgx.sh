#!/bin/sh

export PKGX_LIB="/usr/local/lib/pkgx"

exec sh "$PKGX_LIB/pkgx.sh" "$@"