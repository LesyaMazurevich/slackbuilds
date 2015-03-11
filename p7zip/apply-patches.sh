
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup -z .install --verbose -i ${SB_PATCHDIR}/${NAME}-9.38.1-install.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-9.13-nostrip.patch
### Gentoo
patch -p1 -E --backup -z .kde4 --verbose -i ${SB_PATCHDIR}/${NAME}-9.20-kde4.patch

set +e +o pipefail
