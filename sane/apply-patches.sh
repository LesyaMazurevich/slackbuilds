
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# Fedora-specific, not generally applicable:
if [ "${SB_UACL}" = "YES" ] ;then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sane-backends-1.0.23-udev.patch
fi
# Fedora-specific (for now): make installed sane-config multi-lib aware again
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sane-backends-1.0.23-sane-config-multilib.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
