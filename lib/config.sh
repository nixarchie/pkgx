### ---------------- CONFIG ----------------

# defaults
: "${PKGX_INTERFACE:=generic}"
: "${PKGX_ASSUME_YES:=0}"
: "${PKGX_DRY_RUN:=0}"
: "${PKGX_LOG_LEVEL:=1}"

# configs
[ -f /etc/pkgx.conf ] && source /etc/pkgx.conf
[ -f "$HOME/.config/pkgx.conf" ] && source "$HOME/.config/pkgx.conf"
