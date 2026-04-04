# #!/usr/bin/env bash

# ### ---------------- CONFIG ----------------

# # defaults
# : "${PKGX_INTERFACE:=generic}"
# : "${PKGX_ASSUME_YES:=0}"
# : "${PKGX_DRY_RUN:=0}"
# : "${PKGX_DEBUG:=0}"

# # load configs
# [ -f /etc/pkgx.conf ] && source /etc/pkgx.conf
# [ -f "$HOME/.config/pkgx.conf" ] && source "$HOME/.config/pkgx.conf"

# [ "$PKGX_DEBUG" = 1 ] && set -x

# ### ---------------- FLAGS PARSER ----------------

# ARGS=()

# for arg in "$@"; do
#   case "$arg" in
#     -y|--yes) PKGX_ASSUME_YES=1 ;;
#     --dry-run) PKGX_DRY_RUN=1 ;;
#     --debug) PKGX_DEBUG=1 ;;
#     --interface=*) PKGX_INTERFACE="${arg#*=}" ;;
#     -h|--help)
#       echo "Usage: pkgx <command> [packages] [flags]"
#       exit 0
#       ;;
#     *) ARGS+=("$arg") ;;
#   esac
# done

# # restore positional args
# set -- "${ARGS[@]}"

# ### ---------------- COMMAND MAP ----------------

# declare -A CMD_MAP

# load_interface() {
#   case "$PKGX_INTERFACE" in
#     pacman)
#       CMD_MAP=(
#         [-S]=install_deps
#         [-R]=remove_deps
#         [-Ss]=search_pkg
#         [-Sy]=sync_db
#       )
#       ;;
#     apt)
#       CMD_MAP=(
#         [install]=install_deps
#         [remove]=remove_deps
#         [search]=search_pkg
#         [update]=sync_db
#       )
#       ;;
#     generic|*)
#       CMD_MAP=(
#         [install]=install_deps
#         [add]=install_deps
#         [i]=install_deps

#         [remove]=remove_deps
#         [rm]=remove_deps

#         [search]=search_pkg
#         [sync]=sync_db
#       )
#       ;;
#   esac
# }

# load_interface

# ### ---------------- COMMAND RESOLUTION ----------------

# CMD="$1"
# shift

# FUNC="${CMD_MAP[$CMD]}"

# if ! declare -f "$FUNC" >/dev/null; then
#   echo "Unknown command: $CMD"
#   exit 1
# fi

# ### ---------------- UTIL ----------------

# run_cmd() {
#   if [ "$PKGX_DRY_RUN" = 1 ]; then
#     echo "[DRY RUN] $*"
#   else
#     "$@"
#   fi
# }

# ### ---------------- CORE FUNCTIONS ----------------

# install_deps() {
#   if command -v pacman >/dev/null; then
#     [ "$PKGX_ASSUME_YES" = 1 ] && YES="--noconfirm"
#     run_cmd pacman -S $YES "$@"
#   elif command -v apt >/dev/null; then
#     run_cmd apt install -y "$@"
#   else
#     echo "No supported backend found"
#   fi
# }

# remove_deps() {
#   if command -v pacman >/dev/null; then
#     run_cmd pacman -R "$@"
#   elif command -v apt >/dev/null; then
#     run_cmd apt remove "$@"
#   fi
# }

# search_pkg() {
#   if command -v pacman >/dev/null; then
#     run_cmd pacman -Ss "$@"
#   elif command -v apt >/dev/null; then
#     run_cmd apt search "$@"
#   fi
# }

# sync_db() {
#   if command -v pacman >/dev/null; then
#     run_cmd pacman -Sy
#   elif command -v apt >/dev/null; then
#     run_cmd apt update
#   fi
# }

# ### ---------------- EXECUTE ----------------

# "$FUNC" "$@"
