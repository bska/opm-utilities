#!/bin/bash

set -e

cd /build
pushd ThirdParty/vcpkg
./bootstrap-vcpkg.sh
popd

if ! test -d /python_env/bin
then
  python3 -m venv /python_env
fi

source /python_env/bin/activate
pip3 install -r GrpcInterface/Python/dev-requirements.txt

mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release \
         -DRESINSIGHT_ENABLE_GRPC=ON \
         -DRESINSIGHT_GRPC_PYTHON_EXECUTABLE=/python_env/bin/python3 \
         -DPYTHON_EXECUTABLE=python_env/resinsight-env/bin/python3 \
         -DCMAKE_TOOLCHAIN_FILE=$WORKSPACE/ThirdParty/vcpkg/scripts/buildsystems/vcpkg.cmake \
         -DCMAKE_CXX_COMPILER=/usr/lib/ccache/g++-14 \
         -DCMAKE_C_COMPILER=/usr/lib/ccache/gcc-14 \
         -DRESINSIGHT_GRPC_DOWNLOAD_PYTHON_MODULE=OFF

cmake --build . -j$BUILDTHREADS
