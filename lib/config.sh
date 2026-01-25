#!/usr/bin/env bash
set -euo pipefail

# ---- config locations ----
SYSTEM_CFG="/etc/pkgx/config.yaml"
USER_CFG="$HOME/.config/pkgx/config.yaml"

# ---- build merged config ----
CONFIG_DATA=$(
  yq ea '
    . as $item
    ireduce ({}; . * $item)
  ' \
  $( [[ -f "$SYSTEM_CFG" ]] && echo "$SYSTEM_CFG" ) \
  $( [[ -f "$USER_CFG" ]] && echo "$USER_CFG" )
)

# ---- helpers ----
cfg() {
    yq e "$1 // \"$2\"" - <<<"$CONFIG_DATA" | envsubst
}

# ---- read values ----
#PM=$(cfg '.pm' 'nix')
export backend="$(yq e '.pm.backend' "$USER_CFG")"
export DIRECT="$(cfg '.direct' 'false')"
export GUM="$(cfg '.gum' 'true')"
export CONFIG_DIR="$(cfg '.paths.config_dir' "$HOME/.config/pkgx")"
export LOG_DIR="$(cfg '.paths/log_dir' "$HOME/.local/state/pkgx/logs")"
export PKGX_INTERFACE="$(cfg '.pm.interface' 'generic')"
export PKGX_DEV="$(cfg '.dev' 'false')"

pkgx_config_get() {
    local key="$1"

    if [[ -z "$key" ]]; then
        echo "usage: pkgx config get <key>" >&2
        exit 1
    fi

    yq e ".$key" - <<<"$CONFIG_DATA" | envsubst
}
