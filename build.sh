#!/bin/bash

echo -e "Cleaning"
make clean &> /dev/null
make mrproper &> /dev/null
rm arch/arm64/boot/dtb &> /dev/null
rm arch/arm64/boot/dts/*.dtb &> /dev/null

export ARCH=arm64
export CROSS_COMPILE=../toolchain/bin/aarch64-linux-gnu-
export USE_CCACHE=1

read -p "Enter defconfig name: " defconfig

read -p "Enter android build version: " major

if [ "$major" == "q" ]; then
echo "Building Q kernel"
export ANDROID_MAJOR_VERSION=q
echo -e "CONFIG_DDK_VERSION_OS="q"\nCONFIG_MALI_R29P0=y" >> arch/arm64/configs/$defconfig
else if [ "$major" == "p" ]; then
echo "Building P kernel"
export ANDROID_MAJOR_VERSION=p
echo -e "CONFIG_DDK_VERSION_OS="p"\nCONFIG_MALI_R28P0=y" >> arch/arm64/configs/$defconfig
fi

## Core count check
jobs=$(nproc --all)

## build dtb
make $defconfig
make exynos7870-j7xelte_eur_open_00.dtb exynos7870-j7xelte_eur_open_01.dtb exynos7870-j7xelte_eur_open_02.dtb exynos7870-j7xelte_eur_open_03.dtb exynos7870-j7xelte_eur_open_04.dtb
./tools/dtbtool arch/arm64/boot/dts/ -o arch/arm64/boot/dtb

## build Image
make $defconfig
make -j4

## remove the mali version lines
sed -i '$d' arch/arm64/configs/$defconfig
sed -i '$d' arch/arm64/configs/$defconfig
fi
