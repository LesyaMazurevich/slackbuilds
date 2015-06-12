
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file.etc.file.diff
#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/file.quiet.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file.short.diff

# Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-localmagic.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.10-strength.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-4.17-rpm-name.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.04-volume_key.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.04-man-return-code.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.04-generic-msdos.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.14-x86boot.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.23-perl.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.23-cafebabe.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.22-awk-perl.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.22-zlib.patch

# Mandriva
zcat ${SB_PATCHDIR}/file-4.24-selinux.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-4.21-oracle.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.15-berkeleydb.patch
zcat ${SB_PATCHDIR}/file-4.20-xen.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/file-4.21-svn.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/file-4.20-images.patch
zcat ${SB_PATCHDIR}/file-4.20-apple.patch.gz | patch -p0 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.05-audio.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/file-5.23-xz-container.patch

rm -f magic/Magdir/*{~,.orig}

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
