### ---------------- FLAGS PARSER ----------------

ARGS=()

for arg in "$@"; do
  case "$arg" in
    -y|--yes) PKGX_ASSUME_YES=1 ;;
    --dry-run) PKGX_DRY_RUN=1 ;;
    --debug) PKGX_LOG_LEVEL=2 ;;
    -q|--quiet) PKGX_LOG_LEVEL=0 ;;
    --interface=*) PKGX_INTERFACE="${arg#*=}" ;;
    -h|--help)
      echo "Usage: pkgx <command> [packages] [flags]"
      exit 0
      ;;
    -v*)
      vcount="${arg#-}"
      PKGX_LOG_LEVEL=${#vcount}
      ;;
    --verbose=*) PKGX_LOG_LEVEL="${arg#*=}" ;;
    -V|--version)
      echo "pkgx v0.1.0"
      exit 0
      ;;
    *) ARGS+=("$arg") ;;
  esac
done

set -- "${ARGS[@]}"