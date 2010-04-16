
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

if [ "${PATCHLEVEL}" -gt 0 ] ;then
  for i in $( seq -w ${PATCHLEVEL} ) ; do
    patch -p0 -i ${SVER//.}u${i}.diff
  done
fi

if [ "${SB_GCONF}" != "YES" ] ;then
  zcat ${SB_PATCHDIR}/sdlmame-0.136u2-nogconf.patch.gz | patch -p0 -E --backup -z .nogconf --verbose
fi

set +e +o pipefail