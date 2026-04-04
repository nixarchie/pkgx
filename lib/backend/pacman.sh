#!/usr/bin/env bash

# pacman backend implementation

backend_name="pacman"

backend_install() {
  debug "install: $*"

  local args=(-S --needed)

  [ "$PKGX_ASSUME_YES" = 1 ] && args+=(--noconfirm)

  run_cmd sudo pacman "${args[@]}" "$@"
}

backend_remove() {
  debug "remove: $*"

  local args=(-Rs)

  [ "$PKGX_ASSUME_YES" = 1 ] && args+=(--noconfirm)

  run_cmd sudo pacman "${args[@]}" "$@"
}

backend_search() {
  debug "search: $*"
  run_cmd pacman -Ss "$@"
}

backend_sync() {
  debug "sync db"
  warn "sync without upgrade can cause partial upgrades"
  run_cmd sudo pacman -Sy
}

backend_upgrade() {
  debug "supgrade"

  local args=(-Syu)
  [ "$PKGX_ASSUME_YES" = 1 ] && args+=(--noconfirm)

  run_cmd sudo pacman "${args[@]}"
}
