#!/bin/bash

export ARCH=arm64
export CROSS_COMPILE=../toolchain/bin/aarch64-linux-gnu-

dtbfiles="exynos7870-j7xelte_eur_open_00.dtb exynos7870-j7xelte_eur_open_01.dtb exynos7870-j7xelte_eur_open_02.dtb exynos7870-j7xelte_eur_open_03.dtb exynos7870-j7xelte_eur_open_04.dtb"

make exynos7870-j7xelte_defconfig
make "$dtbfiles"
./tools/dtbtool arch/arm64/boot/dts/ -o arch/arm64/boot/dtb
make -j"$(nproc --all)"
