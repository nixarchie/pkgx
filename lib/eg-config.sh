# ~/.config/pkgx.conf or /etc/pkgx.conf
# ---------------- Example pkgx configuration ----------------

# Interface type (generic, pacman, apt, etc.)
PKGX_INTERFACE="generic"

# Automatically answer yes to prompts (1 = yes, 0 = no)
PKGX_ASSUME_YES=0

# Dry-run mode (1 = simulate commands, 0 = actually run them)
PKGX_DRY_RUN=0

# Logging verbosity:
# 1 = normal, 2 = debug/verbose, 3= set -x
PKGX_LOG_LEVEL=1

# Backend type (which package manager to use)
# Options: pacman, nix and apt (uncomment if needed)
# PKGX_BACKEND=pacman