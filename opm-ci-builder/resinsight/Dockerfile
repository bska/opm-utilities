# This dockerfile builds the docker image for resinsight CI builds

ARG uid="1000"
FROM ubuntu:24.04 AS setup_stage
ARG uid

WORKDIR /tmp/opm
ADD . .

# Make sure we have updated URLs to packages etc.
RUN apt-get update -y

# Make sure we have updated packages
RUN apt-get upgrade -y

# Install system packages
RUN apt-get install -y cmake g++-14 git pkg-config ninja-build ccache \
                       python3 python3-venv qt6-base-dev qt6-svg-dev \
                       qt6-networkauth-dev qt6-base-private-dev \
                       curl zip unzip tar libxkbcommon-dev \
                       linux-libc-dev flex bison libglu1-mesa-dev \
                       octave-dev

FROM setup_stage AS build_stage

# Make a copy of the build script
RUN cp /tmp/opm/build.sh /usr/local/bin/build-resinsight.sh

# Setup system options
RUN scripts/setup_system_options.sh ${uid}

# Remove build directory
RUN rm /tmp/opm -Rf

# Clean up apt cache
RUN apt clean

# Create shared directory
RUN mkdir /build
VOLUME /build

ENV WORKSPACE=/build
ENV CMAKE_GENERATOR=Ninja
ENV CCACHE_DIR=/ccache
ENV VCPKG_DEFAULT_BINARY_CACHE=/vcpkg
ENV X_VCPKG_REGISTRIES_CACHE=/vcpkg/registry
ENV VCPKG_DOWNLOADS=/vcpkg/downloads
ENTRYPOINT ["/usr/local/bin/build-resinsight.sh"]
