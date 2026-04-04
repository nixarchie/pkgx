#!/usr/bin/env bash

# apt backend implementation

backend_name="apt"

backend_install() {
  debug "apt install: $*"

  local args=(install)

  # apt needs -y BEFORE packages
  [ "$PKGX_ASSUME_YES" = 1 ] && args+=(-y)

  run_cmd sudo apt "${args[@]}" "$@"
}

backend_remove() {
  debug "apt remove: $*"

  local args=(remove)

  [ "$PKGX_ASSUME_YES" = 1 ] && args+=(-y)

  run_cmd sudo apt "${args[@]}" "$@"
}

backend_search() {
  debug "apt search: $*"
  run_cmd apt search "$@"
}

backend_sync() {
  debug "apt update"
  run_cmd sudo apt update
}

backend_upgrade() {
    debug "apt update && upgrade"
    backend_sync
    run_cmd sudo apt upgrade
}

backend_update_and_install() {
  backend_sync
  backend_install "$@"
}
