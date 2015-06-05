
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .orig --verbose -i ${SB_PATCHDIR}/m64py-0.2.1-path.patch
patch -p0 -E --backup -z .orig --verbose -i ${SB_PATCHDIR}/m64py-0.2.1-libdir.patch

set +e +o pipefail
