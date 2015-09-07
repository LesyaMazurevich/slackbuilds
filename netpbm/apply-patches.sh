
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-time.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-message.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-security-scripts.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-security-code.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-nodoc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-gcc4.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-bmptopnm.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-CAN-2005-2471.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-xwdfix.patch
zcat ${SB_PATCHDIR}/${NAME}-ppmtompeg.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-multilib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-glibc.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/netpbm-docfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/netpbm-ppmfadeusage.patch
zcat ${SB_PATCHDIR}/netpbm-fiasco-overflow.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-noppmtompeg.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/netpbm-cmuwtopbm.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/netpbm-pamtojpeg2k.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/netpbm-ppmtopict.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/netpbm-disable-pbmtog3.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/netpbm-pnmtops.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/netpbm-config.patch

set +e +o pipefail
