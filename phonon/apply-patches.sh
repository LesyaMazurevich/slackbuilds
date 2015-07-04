
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.7.0-rpath_use_link_path.patch 

## upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-build-with-Qt-5.4.2.patch

set +e +o pipefail
