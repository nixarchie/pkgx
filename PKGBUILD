pkgname=pkgx
pkgver=0.0.0
pkgrel=1
pkgdesc="Cross-distro package manager frontend"
arch=('any')
url="https://github.com/nixarchie/pkgx"
license=('unknown')
depends=('bash' 'fzf')

source=("pkgx-src::git+$url")
sha256sums=('SKIP')

package() {
  cd "$srcdir/pkgx-src"

  # bin
  install -Dm755 pkgx "$pkgdir/usr/local/bin/pkgx"

  # lib
  install -d "$pkgdir/usr/local/lib/pkgx"
  cp -r lib commands pkgx.sh "$pkgdir/usr/local/lib/pkgx/"
}
