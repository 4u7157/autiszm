#!/bin/bash

export ARCH=arm64
export CROSS_COMPILE=../toolchain/bin/aarch64-unknown-linux-gnu-

make exynos7870-j7xlte_defconfig
make -j8
