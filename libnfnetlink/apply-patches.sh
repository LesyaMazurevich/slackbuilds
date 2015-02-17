
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/libnfnetlink-sysheader.patch.gz | patch -p1 -E --backup --verbose

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
