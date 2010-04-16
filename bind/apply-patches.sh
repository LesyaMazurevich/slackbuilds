
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Remove use of SO_BSDCOMPAT which has been obsolete since the 2.2.x kernel series,
# and generates warnings under 2.6.x kernels:
zcat ${SB_PATCHDIR}/bind.so_bsdcompat.diff.gz | patch -p1 --verbose || exit

# The man pages should reflect /var/run/named:
#zcat ${SB_PATCHDIR}/bind.man.diff.gz | patch -p1 --verbose --backup --suffix=.orig

# Common patches
zcat ${SB_PATCHDIR}/bind-nonexec.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind-9.5-PIE.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind-9.5-overflow.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind-9.5-dlz-64bit.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind-9.5-parallel-build.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind-96-libtool2.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind-95-rh452060.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind93-rh490837.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind97-dist-pkcs11.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind97-managed-keyfile.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind97-rh478718.patch.gz | patch -p1 -E --backup --verbose

# needs inpection
zcat ${SB_PATCHDIR}/bind-96-dyndb.patch.gz | patch -p1 -E --backup --verbose

# IDN paches
zcat ${SB_PATCHDIR}/bind-9.5-libidn.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind-9.5-libidn2.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind-9.5-libidn3.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind95-rh461409.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail