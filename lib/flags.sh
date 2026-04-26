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
      echo "Pkgx - Multi-Distro PM frontend"
      echo ""
      echo "Usage: pkgx <command> [packages] [flags]"
      echo ""
      echo "Commands:"
      echo "  install, add, i    Install packages"
      echo "  remove, rm         Remove packages"
      echo "  search             Search for packages"
      echo "  sync               Sync package database"
      echo "  upgrade            Upgrade all packages"
      echo ""
      echo "Flags:"
      echo "  -y, --yes          Assume yes to all prompts"
      echo "  --dry-run          Show commands without executing them"
      echo "  --debug, -v, -vv   Enable debug logging"
      echo "  --interface=<name> Use a specific command interface (generic, pacman, apt, nix)"
      echo "  -h, --help         Show this help message"
      echo "  -V, --version      Show version information"
      echo ""
      echo "Interfaces:"
      echo "  generic            Default commands (install, remove, etc.)"
      echo "  pacman             Arch-style flags (-S, -R, -Ss, -Sy, -Syu)"
      echo "  apt                Debian-style commands (install, remove, update, upgrade)"
      echo "  nix                Nix-style commands (profile install, registry pin, etc.)"
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