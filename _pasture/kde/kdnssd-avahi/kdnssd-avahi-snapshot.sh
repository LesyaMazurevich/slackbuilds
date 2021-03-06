#!/bin/bash

set -e

module=kdnssd-avahi
snaproot="svn://anonsvn.kde.org/home/kde/trunk/playground/network"

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
  set +e
  [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
unset SNAP_COOPTS
pwd=$(pwd)
snap=${snap:-$(date +%Y%m%d)}

[ "${snap}" = "$(date +%Y%m%d)" ] || SNAP_COOPTS="-r {$snap}"

pushd "${tmp}"
  svn --non-recursive checkout ${snaproot} ${module}-${snap}
  svn --non-recursive checkout svn://anonsvn.kde.org/home/kde/branches/KDE/3.5/kde-common/admin/ ${module}-${snap}/admin
  ## auto*/configure bits
  svn up ${module}-${snap}
  ## app
  svn export ${snaproot}/${module} ${module}-${snap}/${module}
  pushd ${module}-${snap}
    find . -type d -name .svn -print0 | xargs -0r rm -r
    ln -s ${module} dnssd
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
