#!/bin/bash

set -ex

PKG="${PACKAGE_NAME:-${1}}"
VERSION="${PACKAGE_VERSION:-${2}}"
ADD_PATCH="${3:-false}"
ZIPFILE="${PKG}-${VERSION}.zip"
ORIG_TARBALL="../${PKG}_${VERSION}.orig.tar.gz"

[ ! -f "${ORIG_TARBALL}" ] || exit 0

SHA=$(echo "${VERSION}" | awk -F'~' '{print $2}')
VER=$(echo "${VERSION}" | awk -F'+' '{print $1}')

rm -rf "${PKG}"*
rm -rf "${PKG}-${VER}"
rm -f "${ZIPFILE}"

wget -c "https://github.com/sarxos/l2fprod-common/archive/${SHA}.zip" -O "${ZIPFILE}" || exit 1

unzip "${ZIPFILE}" || exit 1

rm -f "${ZIPFILE}"

mv "${PKG}"* "${PKG}-${VER}"

find "${PKG}-${VER}" -type f -name '.classpath' -exec rm -f '{}' \;
find "${PKG}-${VER}" -type f -name '.project' -exec rm -f '{}' \;
find "${PKG}-${VER}" -type f -name '*.html' -exec rm -f '{}' \;

find "${PKG}-${VER}" -type f -name '*.java' -exec iconv -f ISO-8859-1 -t UTF-8 '{}' -o '{}'.iconv \; -exec mv '{}'.iconv '{}' \; -exec dos2unix '{}' \;

cp debian/libl2fprod-common-java.pom.xml "${PKG}-${VER}/pom.xml"

if [ "${ADD_PATCH}" != "false" ]
then
   while read -r line
   do
      patch -d "${PKG}-${VER}" -p1 < "debian/patches/${line}"
   done < debian/patches/series
fi

tar -czf "${ORIG_TARBALL}" --exclude-vcs "${PKG}-${VER}" || exit 1

rm -rf "${PKG}-${VER}"
rm -f "${ZIPFILE}"

