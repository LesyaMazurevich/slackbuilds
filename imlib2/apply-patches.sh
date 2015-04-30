
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .multilib --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.7-multilib.patch

set +e +o pipefail
