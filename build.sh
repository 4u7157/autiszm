#!/bin/bash

export ARCH=arm64
export CROSS_COMPILE=../toolchain/bin/aarch64-linux-gnu-

read -p "Enter defconfig name: " defconfig

read -p "Enter android build version: " major

if [major == "q"]
then
export ANDROID_MAJOR_VERSION=q
else if [major == "p"]
export ANDROID_MAJOR_VERSION=p
fi

jobs=$(grep -c '^processor' /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)

make $defconfig
make -j$(jobs)
