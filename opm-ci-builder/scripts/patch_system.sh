#!/bin/bash

set -e

cd /usr/include
patch -p1 < /tmp/opm/patches/dune-common/0001-gpu_patch.patch
patch -p1 < /tmp/opm/patches/dune-istl/0001-missing_initializers.patch
patch -p1 < /tmp/opm/patches/dune-fem/0002-missing_include.patch
patch -p1 < /tmp/opm/patches/dune-grid/0001-gpu_patch.patch

cd /dune/serial
patch -p0 < /tmp/opm/patches/dune-common/0001-gpu_patch.patch
patch -p0 < /tmp/opm/patches/dune-istl/0001-missing_initializers.patch
patch -p0 < /tmp/opm/patches/dune-fem/0002-missing_include.patch
patch -p0 < /tmp/opm/patches/dune-grid/0001-gpu_patch.patch

cd /python_env/lib/python3.12/site-packages/pybind11
patch -p1 < /tmp/opm/patches/pybind11/0001-no_static.patch
