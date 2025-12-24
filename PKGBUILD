# Maintainer: Nixie <nixie@example.com>
pkgname=pkgx
pkgver=0.1.0
pkgrel=1
pkgdesc="Pkgx - a cross-distro package manager frontend"
arch=('x86_64')
url="https://github.com/nixarchie/pkgx"
license=('custom')  # no formal license
depends=('bash'
         'fzf')
source=("./pkgx"
        "./commands"
        "./lib")
sha256sums=('SKIP')  # since it's local, skip checksums

build() {
    # Nothing to build for shell scripts
    :
}

package() {
    echo "→ Installing pkgx to $pkgdir/usr/local/bin"

    # create target dir
    mkdir -p "$pkgdir/usr/local/bin"

    # copy all files
    cp -R pkgx commands lib "$pkgdir/usr/local/bin/"

    # make main binary executable
    chmod +x "$pkgdir/usr/local/bin/pkgx"

    # fix permissions of all .sh files
    find "$pkgdir/usr/local/bin/commands" "$pkgdir/usr/local/bin/lib" -type f -name '*.sh' -exec chmod 755 {} \;
}

