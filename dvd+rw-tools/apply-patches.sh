
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
zcat ${SB_PATCHDIR}/${NAME}-7.0-man.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-7.0-wexit.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-7.0-glibc2.6.90.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-7.0-reload.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-7.0-wctomb.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-7.0-dvddl.patch.gz | patch -p0 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.1-noevent.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.1-lastshort.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.1-format.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.1-bluray_srm+pow.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.1-bluray_pow_freespace.patch

### Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.1-layerbreaksetup.patch

set +e +o pipefail
