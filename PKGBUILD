# Maintainer: Luca Weiss <luca (at) z3ntu (dot) xyz>
# Maintainer: Gabriele Musco <emaildigabry@gmail.com>

# It is possible to build the package from a specific git commit by uncommenting the variable "_commit" and setting it to a valid commit. pkgrel should be bumped up too then.

_newname=openrazer
pkgbase=razer-drivers
pkgname=('python-razer' 'razer-daemon' 'razer-driver-dkms' 'openrazer-meta')
pkgver=1.1.16
#_commit=6ae1f7d55bf10cc6b5cb62a5ce99ff22c43e0701
pkgrel=1
pkgdesc="An entirely open source driver and user-space daemon that allows you to manage your Razer peripherals on GNU/Linux."
arch=('any')
url="https://github.com/openrazer/openrazer"
license=('GPL2')
makedepends=('make' 'python' 'python-setuptools')
if [ -z $_commit ]; then
  source=("https://github.com/openrazer/openrazer/archive/v$pkgver.tar.gz")
else
  source=("https://github.com/openrazer/openrazer/archive/$_commit.tar.gz")
fi
sha256sums=('dd1d934c3b1a50182fa1fca92ab853c2ad761b94a2925eb6ee71f060f233a00f')

package_python-razer() {
  pkgdesc="Python library for accessing the Razer daemon from Python."
  depends=('razer-daemon' 'python' 'python-dbus' 'python-numpy')
  if [ -z $_commit ]; then
    cd $srcdir/$_newname-$pkgver
  else
    cd $srcdir/$_newname-$_commit
  fi
  make DESTDIR=$pkgdir python_library_install
}

package_razer-daemon() {
  pkgdesc="Userspace daemon that abstracts access to the kernel driver. Provides a DBus service for applications to use."
  depends=('razer-driver-dkms' 'python-dbus' 'python-gobject' 'python-setproctitle' 'xautomation' 'xdotool' 'libdbus' 'python-notify2' 'python-pyudev' 'gtk3' 'dbus-glib')
  # gtk3 for "gi.require_version('Gdk', '3.0')"
  install=razer-daemon.install

  if [ -z $_commit ]; then
    cd $srcdir/$_newname-$pkgver
  else
    cd $srcdir/$_newname-$_commit
  fi
  make DESTDIR=$pkgdir daemon_install
}

package_razer-driver-dkms() {
  pkgdesc="Kernel driver for Razer devices (DKMS-variant)"
  depends=('dkms' 'udev')
  provides=('OPENRAZER-MODULES')
  conflicts=('OPENRAZER-MODULES')
  install=razer-driver-dkms.install
  
  if [ -z $_commit ]; then
    cd $srcdir/$_newname-$pkgver
  else
    cd $srcdir/$_newname-$_commit
  fi
  make DESTDIR=$pkgdir setup_dkms udev_install
}

package_openrazer-meta() {
  pkgdesc="Meta package for installing all required openrazer packages."
  depends=('razer-driver-dkms' 'razer-daemon' 'python-razer')
  optdepends=('polychromatic: frontend'
              'razergenie: qt frontend'
              'razercommander: gtk frontend')
}

