
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# Patch in the uname for Linux enhancements
if [ "${SB_RHUNAME}" = "YES" ] ;then
  # Fedora/Red Hat patch.
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-8.2-uname-processortype.patch
else
  # Slackware patch
  zcat ${SB_PATCHDIR}/${NAME}.uname.diff.gz | patch -p1 --verbose --backup --suffix=.orig
fi

# From upstream

# Fedora patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-6.10-configuration.patch
# add note about no difference between binary/text mode on Linux - md5sum manpage
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-6.10-manpages.patch
# temporarily workaround probable kernel issue with TCSADRAIN
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.4-sttytcsadrain.patch
#df --direct
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-df-direct.patch
#add note about mkdir --mode behaviour into info documentation(#610559)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-8.4-mkdir-modenote.patch

# sh-utils
# add info about TZ envvar to date manpage
zcat ${SB_PATCHDIR}/sh-utils-2.0.11-dateman.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.3-langinfo.patch

# (sb) lin18nux/lsb compliance
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-i18n.patch

# getgrouplist() patch from Ulrich Drepper.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-getgrouplist.patch
# Prevent buffer overflow in who(1).
zcat ${SB_PATCHDIR}/${NAME}-overflow.patch.gz | patch -p1 -E --backup --verbose

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
