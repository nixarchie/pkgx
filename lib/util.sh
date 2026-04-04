### ---------------- UTIL ----------------

# log level
PKGX_LOG_LEVEL=${PKGX_LOG_LEVEL:-1}

# colors
PKGX_CLR_RESET="\033[0m"
PKGX_CLR_BLUE="\033[1;34m"
PKGX_CLR_GREEN="\033[1;32m"
PKGX_CLR_YELLOW="\033[1;33m"
PKGX_CLR_RED="\033[1;31m"
PKGX_CLR_GRAY="\033[0;90m"

# prefix
pkgx_prefix() {
  echo -ne "${PKGX_CLR_BLUE}[pkgx]${PKGX_CLR_RESET} "
}

# info (level 1+)
info() {
  [ "$PKGX_LOG_LEVEL" -lt 1 ] && return
  pkgx_prefix
  echo -e "$*"
}

# debug (level 2+)
debug() {
  [ "$PKGX_LOG_LEVEL" -lt 2 ] && return
  local func="${FUNCNAME[1]}"
  pkgx_prefix
  echo -e "${PKGX_CLR_GRAY}[debug][$func]${PKGX_CLR_RESET} $*"
}

# warning
warn() {
  pkgx_prefix
  echo -e "${PKGX_CLR_YELLOW}$*${PKGX_CLR_RESET}"
}

# error
error() {
  pkgx_prefix
  echo -e "${PKGX_CLR_RED}$*${PKGX_CLR_RESET}" >&2
}

# command runner
run_cmd() {
  debug "running: $*"

  if [ "$PKGX_DRY_RUN" = 1 ]; then
    pkgx_prefix
    echo -e "${PKGX_CLR_YELLOW}[DRY RUN]${PKGX_CLR_RESET} $*"
  else
    "$@"
  fi
}

# debug
enable_debug() {
  case "$PKGX_LOG_LEVEL" in
    2)
      debug "debug mode enabled"
      [ -n "$PKGX_BACKEND" ] && debug "backend: $PKGX_BACKEND"
      ;;
    3)
      info "entering trace mode (set -x)"

      # better trace format
      PS4='+ pkgx:${BASH_SOURCE##*/}:${LINENO}:${FUNCNAME[0]}: '

      set -x
      ;;
  esac
}
if [ "$PKGX_LOG_LEVEL" -gt 3 ]; then
  PKGX_LOG_LEVEL=3
fi
