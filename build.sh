#!/bin/bash

export ARCH=arm64
export CROSS_COMPILE=../toolchain/bin/aarch64-linux-gnu-

read -p "Enter defconfig name: " defconfig

read -p "Enter android build version: " major

if [major == "q"]
then
export ANDROID_MAJOR_VERSION=q
echo -e "CONFIG_DDK_VERSION_OS="q"\nCONFIG_MALI_R29P0=y" >> $defconfig
else if [major == "p"]
export ANDROID_MAJOR_VERSION=p
echo -e "CONFIG_DDK_VERSION_OS="p"\nCONFIG_MALI_R28P0=y" >> $defconfig
fi

jobs=$(grep -c '^processor' /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)

make $defconfig
make -j$(jobs)
