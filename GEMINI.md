# GEMINI.md - Project Context for Pkgx

## Project Overview
**Pkgx** is a multi-distribution package manager frontend written in Bash. It provides a unified and consistent interface for package management across various Linux distributions, currently supporting **Arch Linux (pacman)**, **Debian/Ubuntu (apt)**, and **Nix**.

The project aims to simplify cross-distro package management by allowing users to use either generic commands (e.g., `pkgx install`) or distribution-specific flags (e.g., `pkgx -S`) regardless of the underlying system.

### Key Technologies
- **Bash:** The primary language for the core logic and command scripts.
- **Makefile:** Used for installation and basic syntax checks.

### Architecture
- **Entry Point (`pkgx`):** A wrapper script that detects the installation root, loads libraries, and dispatches commands to their respective implementations.
- **Libraries (`lib/`):**
    - `config.sh`: Handles configuration loading from environment variables and files.
    - `flags.sh`: Parses command-line flags (e.g., `--dry-run`, `--yes`).
    - `backend.sh`: Detects the system's package manager and loads the corresponding backend implementation.
    - `map.sh`: Maps user commands to internal functions based on the configured interface.
    - `util.sh`: Provides logging utilities (`debug`, `info`, `warn`, `error`) and command execution wrappers.
- **Backends (`lib/backend/`):** Contains distribution-specific logic for `apt`, `pacman`, and `nix` (modern flake-based implementation).
- **Commands (`commands/`):** Modularized frontend commands (e.g., `install.sh`, `remove.sh`, `search.sh`) that call backend-agnostic functions.

---

## Building and Running

### Installation
- **User Install:** Runs `make install` to install `pkgx` to `~/.local/bin` and its libraries to `~/.local/lib/pkgx`.
- **System Install:** (Implicitly supported via `/usr/local/lib/pkgx` detection in the main script).

### Key Commands
- **Install Package:** `pkgx install <pkg>` (or `pkgx -S <pkg>` if using the pacman interface).
- **Remove Package:** `pkgx remove <pkg>` (or `pkgx -R <pkg>`).
- **Search Package:** `pkgx search <pkg>`.
- **Sync Database:** `pkgx sync`.
- **Upgrade System:** `pkgx upgrade`.

### Testing
- **Syntax Check:** Run `make check` to perform `sh -n` on all shell scripts.
- **Functional Tests:** Run `./test.sh` to execute the comprehensive test suite. This script verifies:
    - Command formatting for various backends (pacman, apt).
    - Flag handling (e.g., `--dry-run`, `--yes`).
    - Interface mapping (using generic or distro-specific commands).
    - Backend detection and overrides.

---

## Development Conventions

### Coding Style
- **Modularity:** Keep commands and backend logic separate. New features should be added to `commands/`, while new distribution support belongs in `lib/backend/`.
- **Logging:** Use the logging functions provided in `lib/util.sh` instead of raw `echo`.
- **Safe Execution:** Always use `run_cmd` for operations that modify the system to respect the `--dry-run` flag.

### Configuration
`pkgx` can be configured via:
- **Environment Variables:** `PKGX_INTERFACE`, `PKGX_ASSUME_YES`, `PKGX_DRY_RUN`, `PKGX_LOG_LEVEL`.
- **Config Files:** `/etc/pkgx.conf` or `~/.config/pkgx/pkgx.conf` (for global settings), and `~/.config/pkgx/config.sh` (for library-level overrides).

### Adding a New Backend
1. Create a new script in `lib/backend/<name>.sh`.
2. Implement the required functions: `backend_install`, `backend_remove`, `backend_search`, `backend_sync`, `backend_upgrade`.
3. Update `lib/backend.sh` to detect the new backend.
