#!/bin/bash

export ARCH=arm64
export CROSS_COMPILE=../toolchain/bin/aarch64-linux-gnu-

make exynos7870-j7xelte_defconfig
make -j8
