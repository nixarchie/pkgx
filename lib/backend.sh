#!/usr/bin/env bash

detect_backend() {
  if command -v pacman >/dev/null; then
    echo "pacman"
  elif command -v apt >/dev/null; then
    echo "apt"
  elif command -v nix >/dev/null; then
    echo "nix"
  else
    error "No supported backend found"
    exit 1
  fi
}

PKGX_BACKEND="${PKGX_BACKEND:-$(detect_backend)}"

# load backend
source "$PKGX_ROOT/lib/backend/$PKGX_BACKEND.sh"

debug "loaded backend: $PKGX_BACKEND"