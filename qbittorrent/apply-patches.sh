
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/build_flags.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/remove-donate.patch

set +e +o pipefail
