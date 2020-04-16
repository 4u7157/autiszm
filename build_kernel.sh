#!/bin/bash

export ANDROID_MAJOR_VERSION=q

make ARCH=arm64 exynos7870-a6lte_defconfig

PATH="../clang/bin:../toolchain/bin:${PATH}" \
make -j$(nproc --all) \
                      ARCH=arm64 \
                      CC=clang \
                      CROSS_COMPILE=aarch64-gnu-
