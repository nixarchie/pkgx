<div align="center">
    <h1>【 Pkgx — Multi-distro pm fruntend 】</h1>
    <h3></h3>
</div>

<div align="center">

![](https://img.shields.io/github/last-commit/nixarchie/pkgx?style=for-the-badge&color=8ad7eb&logo=git&logoColor=D9E0EE&labelColor=1E202B)
![](https://img.shields.io/github/stars/nixarchie/pkgx?style=for-the-badge&logo=andela&color=86dbd7&logoColor=D9E0EE&labelColor=1E202B)
![](https://img.shields.io/github/repo-size/nixarchie/pkgx?color=86dbce&label=SIZE&logo=protondrive&style=for-the-badge&logoColor=D9E0EE&labelColor=1E202B)

</div>

> 🚨 **CRITICAL WARNING: This project is still under heavy development!** 🚨
>
> This README is not up to date at the moment and is extermly outdated with the current
> development plan

<!--<div align="center">
    <h2>• overview •</h2>
    <h3></h3>
</div>

<details>
  <summary>Notable features</summary>

- **Overview**: This repository automates setting up your terminal workflow and dotfiles across multiple Linux distributions.
- **Distro Support**: It works on Arch, Debian/Ubuntu, Fedora, NixOS(No idea how it will behave), and even supports Brew and Flatpak.
- **Transparent installation**: Every command is shown before it's run.

<!--
- **Automatic setup**: with the `--auto` flag everything will be automatically installed and setup with proper symlinks using python.
-->

</details>
<details>
  <summary>Installation</summary>

- Just run:

  ```bash
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/nixarchie/pkgx/main/install)"
  ```

- Or:

```bash
    git clone https://github.com/nixarchie/pkgx.git
    cd pkgx
    sudo make install
```

- Alternatively, on Arch:

```bash
git clone https://github.com/nixarchie/pkgx.git
cd pkgx
makepkg -si
```

</details>

<!--

<details>
  <summary>Repo overview</summary>

    Dots/
    ├── install.sh                 Main entry point, sources modular scripts
    ├── config                       Contains files pointing to $HOME/.config
    │   ├── fish                     Fish config files
    │   ├── foot                     Foot config files
    │   ├── fuzzel                   Fuzzel config files
    │   └── kitty                    Kitty config files
    ├── home                         Contains files pointing to $HOME
    │   ├── shellconf                Alis and function files to be listed here
    │   │   ├── function.fish        Functions for Fish
    │   │   ├── function.zsh         Functions for Z Shell(zsh)
    │   │   ├── z_alias.fish         Alias for fish
    │   │   └── z_alias.zsh          Alias for Z Shell
    │   ├── .bashrc                  Bash config
    │   └── .zshrc                   Zsh config
    ├── pkgs
    │   ├── arch.txt                 Arch-specific packages
    │   ├── common.txt               Packages installed on all distros
    │   ├── debian.txt               Debian/Ubuntu-specific packages
    │   ├── fedora.txt               Fedora-specific packages
    │   └── nix.txt                  Nix package manager(Works in NixOS & w/o)
    └── scripts
        ├── bash                     Contains bash scripts
        └── python                   Contains python scripts

- Everything is written in `bash` and `python`.

- Note: Only some top-level files are shown; each config folder contains multiple dotfiles.

</details>

-->

<div align="center">
    <h2>• usage •</h2>
    <h3></h3>
</div>

```bash
pkgx add <pkg...>      # Add/install package(s)
pkgx rm <pkg...>       # Remove package(s)
pkgx sync              # Sync package database
pkgx list <pattern>    # List installed packages or search
pkgx menu              # Interactive menu
```

<!--pkgx install <profile>-->

<div align="center">
    <h2>• notes •</h2>
    <h3></h3>
</div>

- **The user is expected to backup important files beforehand**.

- The scripts are currently focused on Arch, as it is what the creator (me) used to create them.

<div align="center">
    <h3> Enjoy your setup! 🚀 </h3>
    <h4></h4>
</div>

<div align="center">

<!--
<h2>• copying •</h2>

- Copying: Personally I have absolutely no problem with others redistributing/recreating my work. There's no "stealing" (maybe unless you loudly do weird stuff).

</div>
-->
<div align=center>

<!--<h2>• contributing •</h2>
If you have any ideas/improvements feel free to open an issue/pr. Otherwise you can contact me on <a href="https://www.reddit.com/user/TGamer_1/">reddit</a>.(I may respond a bit late)-->

Copyright (c) 2025 nixarchie

This project is under active development.
No license is granted at this time.

<h3></h3>

</div>

**P.S. The scripts were written on Arch Linux and haven’t yet been tested on other distros.**
