#!/bin/bash
version=$1
release=$2
if [ ! "$version" ] || [ ! "$release" ]; then
    echo "Usage: $0 <new-version> <release>"
    exit 1
fi

source common.sh

readonly SRCDIR=$(rpm --eval '%{_sourcedir}')

spectool -g -R openrazer.spec
tar -xOf "$SRCDIR/openrazer-$version.tar.xz" '*/debian/changelog' | ./rpm_changelog.py > "$SRCDIR/openrazer-$version.changelog"
rpmbuild -bb --define "rel $release" --with=changelog openrazer.spec
