#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="git://github.com/hrydgard/${module}.git"

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
  set +e
  [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
pwd=$(pwd)
snap=${snap:-$(date +%Y%m%d)}
snapbranch=${snapbranch:-master}
gittree=${gittree:-${snapbranch}}

[ "${snap}" = "$(date +%Y%m%d)" ] && SNAP_COOPTS="--depth 1"
[ "${snapbranch}" = "master" ] || snapbranch="origin/${snapbranch}"

pushd "${tmp}"
  git clone ${SNAP_COOPTS} ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    git submodule update --init
    git submodule update --recursive
    if [ "${snap}" != "$(date +%Y%m%d)" ] && [ -z "${snaptag}" ] ; then
      gitdate="$(echo -n ${snap} | head -c -4)-$(echo -n ${snap} | tail -c -4|head -c -2)-$(echo -n ${snap} | tail -c -2)"
      git checkout $(git rev-list -n 1 --before="${gitdate}" ${snapbranch})
      gittree=$(git reflog | grep 'HEAD@{0}' | awk '{print $1}')
    fi
    if [ "${snapbranch}" != "master" ] && [ -z "${snaptag}" ];then
      git checkout -q ${gittree}
    fi
    if [ -n "${snaptag}" ] ;then
      if git tag | grep -q ${snaptag} ;then
        git checkout ${snaptag}
      else
        echo "Tag not found! Printing available."
        git tag
        exit 1
      fi
    fi
    rm -rf ffmpeg/* dx9sdk/* pspautotests/* redist/*
    GITVER="$(git describe --always)"
    sed -i \
      -e "/GIT_VERSION/s|unknown|${GITVER}|g" \
      -e "/COMMAND/s|\${GIT_EXECUTABLE} describe --always|echo \"${GITVER}\"|g" \
      git-version.cmake
    find . -type d -name .git -print0 | xargs -0r rm -rf
    find . -type f -name .gitignore -print0 | xargs -0r rm -f
    rm -rf .hgeol .hgignore config.git-hash
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
