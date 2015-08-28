
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cryptopp-autotools.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cryptopp-s390.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cryptopp-data-files-location.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/cryptopp-x86-disable-sse2.patch

set +e +o pipefail
