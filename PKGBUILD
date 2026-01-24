pkgname=pkgx
pkgver=0.1.1
pkgrel=1
pkgdesc="Cross-distro package manager frontend"
arch=('any')
url="https://github.com/nixarchie/pkgx"
license=('none')
depends=('bash' 'fzf')
conflicts=('pkgx')

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
