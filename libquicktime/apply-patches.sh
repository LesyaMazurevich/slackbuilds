
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Mageia
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libquicktime-1.2.4-ffmpeg-2.8.patch

set +e +o pipefail
