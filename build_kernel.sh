#!/bin/bash

export ARCH=arm64
export CROSS_COMPILE=../toolchain/bin/aarch64-unknown-linux-gnu-
export ANDROID_MAJOR_VERSION=q

make exynos7870-a6lte_defconfig
make -j8
