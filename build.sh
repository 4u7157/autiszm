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

## b1g memes here W.I.P
if [ "$defconfig" == "exynos7870-j7xelte_defconfig" ]; then
read -p "Non Treble AOSP(1) or Treble AOSP(2) or OneUI(3) or Treble OneUI(4): " type

else if [ "$defconfig" == "exynos7870-j7velte_defconfig" ]; then
read -p "Non Treble AOSP(1) or Treble AOSP(2) or OneUI(3) or Treble OneUI(4): " type


else if [ "$defconfig" == "exynos7870-on7xelte_defconfig" ]; then
read -p "Non Treble AOSP(1) or Treble AOSP(2) or OneUI(3) or Treble OneUI(4): " type


else if [ "$defconfig" == "exynos7870-a3y17lte_defconfig" ]; then
read -p "Non Treble AOSP(1) or Treble AOSP(2) or OneUI(3) or Treble OneUI(4): " type


else if [ "$defconfig" == "exynos7870-j5y17lte_defconfig" ]; then
read -p "Non Treble AOSP(1) or Treble AOSP(2) or OneUI(3) or Treble OneUI(4): " type


else if [ "$defconfig" == "exynos7870-j7y17lte_defconfig" ]; then
read -p "Non Treble AOSP(1) or Treble AOSP(2) or OneUI(3) or Treble OneUI(4): " type


else if [ "$defconfig" == "exynos7870-on7xreflte_defconfig" ]; then
read -p "Non Treble AOSP(1) or Treble AOSP(2) or OneUI(3) or Treble OneUI(4): " type


## these don't need dtb change because they are always treble
else if [ "$defconfig" == "exynos7870-a6lte_defconfig" ]; then
read -p "AOSP(1) or OneUI(3): " type
else if [ "$defconfig" == "exynos7870-j6lte_defconfig" ]; then
read -p "AOSP(1) or OneUI(3): " type
else if [ "$defconfig" == "exynos7870-m10lte_defconfig" ]; then
read -p "AOSP(1) or OneUI(3): " type
fi
################################################################################ b1g meme end

## automatic mali version based on input
if [ "$major" == "p" ]; then
echo "Building P kernel"
export ANDROID_MAJOR_VERSION=p
echo -e "CONFIG_DDK_VERSION_OS="p"\nCONFIG_MALI_R28P0=y" >> arch/arm64/configs/$defconfig
else if [ "$major" == "q" ]; then
echo "Building Q kernel"
export ANDROID_MAJOR_VERSION=q
echo -e "CONFIG_DDK_VERSION_OS="q"\nCONFIG_MALI_R29P0=y" >> arch/arm64/configs/$defconfig
fi

## Core count check
jobs=$(nproc)

## dtb
make $defconfig
make exynos7870-j7xelte_eur_open_00.dtb exynos7870-j7xelte_eur_open_01.dtb exynos7870-j7xelte_eur_open_02.dtb exynos7870-j7xelte_eur_open_03.dtb exynos7870-j7xelte_eur_open_04.dtb
./tools/dtbtool arch/arm64/boot/dts/ -o arch/arm64/boot/dtb

## build Image
make $defconfig
make -j$jobs

## remove the mali version lines
sed -i '$d' arch/arm64/configs/$defconfig
sed -i '$d' arch/arm64/configs/$defconfig

## samsung usb remover for treble
if [ "$type" == "1" ]; then
sed -i '$d' arch/arm64/configs/$defconfig
else if [ "$type" == "2" ]; then
sed -i '$d' arch/arm64/configs/$defconfig
fi
fi
fi
fi
fi
fi
fi
fi
fi
fi
fi

