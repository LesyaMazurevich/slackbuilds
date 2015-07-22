
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Put modules cache in /usr/lib${LIBDIRSUFFIX}/pango
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pango-modules-cache-dir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pango-overflow-fix-for-pangoft2.patch

set +e +o pipefail
