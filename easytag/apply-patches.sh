
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.10-avoid-close-button-crash.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
