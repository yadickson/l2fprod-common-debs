# Debian Package for L2FProd Common Project

[![TravisCI Status][travis-image]][travis-url]

**Build dependencies**

- debhelper (>= 9)
- cdbs
- default-jdk
- maven-debian-helper (>= 1.5)
- libjcalendar-java (>= 1.3.2)

**Download source code**

- unzip
- wget
- libc-bin
- dos2unix 

```
$ debian/rules get-orig-source
$ debian/rules publish-source
```

**Build project**

```
$ dpkg-buildpackage -rfakeroot -D -us -uc -i -I -sa
```
or
```
$ QUILT_PATCHES=debian/patches quilt push -a
$ fakeroot debian/rules clean binary
```

**Tested**

- Debian wheezy
- Debian jessie
- Debian stretch
- Debian buster

**Repositories**

[Debian repository](https://bintray.com/yadickson/debian)

```
$ wget -qO - https://bintray.com/user/downloadSubjectPublicKey?username=bintray | sudo apt-key add -
```
```
$ echo "deb https://dl.bintray.com/yadickson/debian [distribution] main" | sudo tee -a /etc/apt/sources.list.d/bintray.list
```
```
$ sudo apt-get update
$ sudo apt-get upgrade -y
$ sudo apt-get install libl2fprod-common-java
```

## License

GPL-3.0 © [Yadickson Soto](https://github.com/yadickson)

Apache-2.0 © [L2FProd.com Common Components](http://freshmeat.sourceforge.net/projects/l2fprod-common)

MIT © [Bartosz Firyn (SarXos)](https://github.com/sarxos/l2fprod-common)

[travis-image]: https://api.travis-ci.org/yadickson/l2fprod-common-debs.svg?branch=buster
[travis-url]: https://travis-ci.org/yadickson/l2fprod-common-debs

