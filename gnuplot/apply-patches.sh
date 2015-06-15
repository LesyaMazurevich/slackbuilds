
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-4.2.0-refers_to.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.2.0-fonts.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.0.1-xcopygc-sigsegv.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.6.1-plot-sigsegv.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.6.4-singlethread.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.0.0-lua_checkint.patch

set +e +o pipefail
