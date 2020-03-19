#!/bin/bash

echo -e "Cleaning\n"
make clean
make mrproper
rm arch/arm64/boot/dtb
rm arch/arm64/boot/dts/*.dtb

export ARCH=arm64
export CROSS_COMPILE=../toolchain/bin/aarch64-linux-gnu-

read -p "Enter defconfig name: " defconfig

read -p "Enter android build version: " major

if [major == "q"]
then
echo "Build Q kernel"
export ANDROID_MAJOR_VERSION=q
echo -e "CONFIG_DDK_VERSION_OS="q"\nCONFIG_MALI_R29P0=y" >> $defconfig
else if [major == "p"]
echo "Build P kernel"
export ANDROID_MAJOR_VERSION=p
echo -e "CONFIG_DDK_VERSION_OS="p"\nCONFIG_MALI_R28P0=y" >> $defconfig
fi

## Core count check
jobs=$(nproc -all)

## dtb
make $defconfig
make exynos7870-j7xelte_eur_open_00.dtb exynos7870-j7xelte_eur_open_01.dtb exynos7870-j7xelte_eur_open_02.dtb exynos7870-j7xelte_eur_open_03.dtb exynos7870-j7xelte_eur_open_04.dtb
./tools/dtbtool arch/arm64/boot/dts/ -o arch/arm64/boot/dtb

make $defconfig
make -j$(jobs)
