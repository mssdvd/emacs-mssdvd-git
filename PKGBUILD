# Maintainer: Davide Masserut <dm@mssdvd.com>
# Contributor: Juergen Hoetzel <juergen@archlinux.org>
# Contributor: Frederik Schwan <freswa at archlinux dot org>
# Contributor: Jaroslav Lichtblau <svetlemodry@archlinux.org>
# Contributor: Renchi Raju <renchi@green.tam.uiuc.edu>
# Contributor: Pedro A. López-Valencia

pkgname=emacs-mssdvd-git
pkgver=29.0.50.157965
pkgrel=1
pkgdesc='The extensible, customizable, self-documenting real-time display editor.'
arch=('x86_64')
url='https://www.gnu.org/software/emacs/emacs.html'
license=('GPL3')
depends=(
  gmp
  gnutls
  jansson
  lcms2
  libacl.so
  libasound.so
  libdbus-1.so
  libfontconfig.so
  libfreetype.so
  libgdk-3.so
  libgdk_pixbuf-2.0.so
  libgif.so
  libgio-2.0.so
  libglib-2.0.so
  libgobject-2.0.so
  libgpm.so
  libgtk-3.so
  libharfbuzz.so
  libice
  libjpeg.so
  libncursesw.so
  libotf
  libpango-1.0.so
  libpng
  librsvg-2.so
  libsm
  libsystemd.so
  libtiff.so
  libxfixes
  libxml2.so
  m17n-lib
  zlib

  libgccjit
)
makedepends=(git)
provides=(emacs)
conflicts=(emacs)
options=(debug !strip)
source=("emacs-master::git+file//emacs-master")
b2sums=('SKIP')

pkgver() {
  cd "$srcdir/emacs-master"

  printf "%s.%s" \
    "$(grep AC_INIT configure.ac | \
    awk -F',' '{ gsub("[ \\[\\]]","",$2); print $2 }')" \
    "$(git rev-list --count HEAD)"
}

build() {
  local _conf="--sysconfdir=/etc \
    --prefix=/usr \
    --libexecdir=/usr/lib \
    --localstatedir=/var \
    --with-cairo \
    --with-harfbuzz \
    --with-libsystemd \
    --with-modules \
    --with-pgtk \
    --with-native-compilation"

  export ac_cv_lib_gif_EGifPutExtensionLast=yes

  cd "$srcdir/emacs-master"
  [[ -x configure ]] || ./autogen.sh
  ./configure $_conf
  make
}

package() {
  cd "$srcdir/emacs-master"
  make DESTDIR="$pkgdir/" install

  # remove conflict with ctags package
  mv "$pkgdir"/usr/bin/{ctags,ctags.emacs}
  mv "$pkgdir"/usr/share/man/man1/{ctags.1.gz,ctags.emacs.1}

  # fix user/root permissions on usr/share files
  find "$pkgdir"/usr/share/emacs/ -exec chown root:root {} \;
}
