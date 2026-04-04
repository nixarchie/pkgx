pkgname=pkgx
pkgver=1.0.0
pkgrel=1
pkgdesc="Cross-distro package manager frontend"
arch=('any')
url="https://github.com/nixarchie/pkgx"
license=('none')
depends=('bash')
conflicts=('pkgx')

source=("pkgx-src::git+$url")
sha256sums=('SKIP')

package() {
    cd "$srcdir/pkgx-src"

    # ---- system bin ----
    install -Dm755 pkgx "$pkgdir/usr/local/bin/pkgx"

    # ---- lib and commands ----
    install -d "$pkgdir/usr/local/lib/pkgx"
    cp -r lib commands "$pkgdir/usr/local/lib/pkgx/"

    # ---- system config (only if missing) ----
    install -d "$pkgdir/etc/pkgx"
    if [ -f lib/config.sh ]; then
        # Copy only if not already present
        [ ! -f "$pkgdir/etc/pkgx/config.sh" ] && cp lib/config.sh "$pkgdir/etc/pkgx/config.sh"
    fi
}