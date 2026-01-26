pkgname=pkgx
pkgver=1.0.0
pkgrel=1
pkgdesc="Cross-distro package manager frontend"
arch=('any')
url="https://github.com/nixarchie/pkgx"
license=('none')
depends=('bash' 'fzf' 'gum' 'go-yq')
conflicts=('pkgx' 'yq')

source=("pkgx-src::git+$url")
sha256sums=('SKIP')

package() {
  cd "$srcdir/pkgx-src"

  # ---- system bin ----
  install -Dm755 pkgx "$pkgdir/usr/local/bin/pkgx"

  # ---- lib ----
  install -d "$pkgdir/usr/local/lib/pkgx"
  cp -r lib commands pkgx.sh "$pkgdir/usr/local/lib/pkgx/"

  # ---- system config ----
  install -d "$pkgdir/etc/pkgx"
  cp lib/config.yaml "$pkgdir/etc/pkgx/config.yaml"
}
