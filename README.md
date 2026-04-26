<div align="center">
    <h1>【 Pkgx — Multi-Distro PM frontend 】</h1>
    <h3>Unified package management across Arch, Debian, and Nix</h3>
</div>

<div align="center">

![](https://img.shields.io/github/last-commit/nixarchie/pkgx?style=for-the-badge&color=8ad7eb&logo=git&logoColor=D9E0EE&labelColor=1E202B)
![](https://img.shields.io/github/stars/nixarchie/pkgx?style=for-the-badge&logo=andela&color=86dbd7&logoColor=D9E0EE&labelColor=1E202B)
![](https://img.shields.io/github/repo-size/nixarchie/pkgx?color=86dbce&label=SIZE&logo=protondrive&style=for-the-badge&logoColor=D9E0EE&labelColor=1E202B)

</div>

## 🚀 Overview

`pkgx` is a lightweight Bash-based package manager frontend designed to provide a consistent experience across multiple Linux distributions. Whether you're on Arch, Ubuntu, or using Nix, you can use the same commands (or your favorite distro's flags) to manage your system.

### ✨ Key Features
- **Multi-Backend Support**: Works with `pacman`, `apt`, and `nix` (modern flake-based profiles).
- **Interface Mapping**: Use `generic` commands, or emulate `pacman`, `apt`, or `nix` syntax.
- **Dry Run Mode**: Preview exactly what commands will be executed with `--dry-run`.
- **Zero Dependencies**: Pure Bash script that wraps your existing package managers.
- **Extensible**: Simple modular architecture for adding new commands or backends.

## 🛠 Installation

### Quick Install (via curl)
Run the following command to install `pkgx` directly:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/nixarchie/pkgx/main/install)"
```

### Manual Install
Alternatively, clone the repository and run the installation script:

```bash
git clone https://github.com/nixarchie/pkgx.git
cd pkgx
make install
```

This installs `pkgx` to `~/.local/bin` and its libraries to `~/.local/lib/pkgx`.

## 📖 Usage

### Generic Interface (Default)
```bash
pkgx install bash
pkgx remove vim
pkgx search python
pkgx sync
pkgx upgrade
```

### Interface Emulation
You can use flags from other package managers by setting the interface:

```bash
# Use pacman flags on Ubuntu
pkgx --interface=pacman -S htop

# Use Nix profile commands on Arch
pkgx --interface=nix profile install neofetch
```

### Global Flags
- `-y, --yes`: Assume yes to all prompts (e.g., `--noconfirm` or `-y`).
- `--dry-run`: Show the command that would be run without executing it.
- `--debug`: Enable verbose logging for troubleshooting.

## 🧪 Testing

`pkgx` comes with a comprehensive test suite to ensure backend and interface mapping integrity:

```bash
./test.sh
```

## 📜 License

This project is open-source. See the source code for more details.

---
<div align="center">
    <h3> Enjoy! 🚀 </h3>
</div>
