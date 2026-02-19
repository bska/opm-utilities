#!/bin/bash

OPTIND=1
while getopts "b:c:d:R:" OPT
do
    case "${OPT}" in
        b) PROJECT_BINARY_DIR=${OPTARG} ;;
        c) CLEAN_DIRS=${OPTARG} ;;
        d) DOCKER_IMAGE=${OPTARG} ;;
        R) REPO_ROOT=${OPTARG} ;;
    esac
done

if ! test -d ResInsight
then
  git clone $REPO_ROOT
  cd ResInsight
  git submodule init
  git submodule update
  cd ..
fi

rm -rf ResInsight/build

mkdir -p ccache
mkdir -p python_env
mkdir -p vcpkg/registry
mkdir -p vcpkg/downloads

docker run --rm  \
           -u $(id -u) \
           -v ${PROJECT_BINARY_DIR}/ResInsight:/build \
           -v ${PROJECT_BINARY_DIR}/ccache:/ccache \
           -v ${PROJECT_BINARY_DIR}/vcpkg:/vcpkg \
           -v ${PROJECT_BINARY_DIR}/python_env:/python_env \
           ${DOCKER_IMAGE}
res=$?

if ! test $res -eq 0
then
    MSG="Docker returned error code ${res}"
fi

if [ "${CLEAN_DIRS}" = "ON" ] || [ "${CLEAN_DIRS}" = "1" ]
then
    rm -Rf ${ROOT_DIR}
fi

if test -n "${MSG}"
then
    echo -e ${MSG}
    exit 1
fi
