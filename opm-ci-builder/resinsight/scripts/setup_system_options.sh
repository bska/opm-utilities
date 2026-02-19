#!/bin/bash

set -e

usermod -u $1 ubuntu
groupmod -g $1 ubuntu

update-alternatives --install /usr/bin/gcc gcc-14 /usr/bin/gcc-14 100
update-alternatives --install /usr/bin/g++ g++-14 /usr/bin/g++-14 100
