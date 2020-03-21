#!/bin/bash

echo -e "Cleaning"
make clean &> /dev/null
make mrproper &> /dev/null
rm arch/arm64/boot/dtb &> /dev/null
rm arch/arm64/boot/dts/*.dtb &> /dev/null
rm arch/arm64/kernel/vdso/vdso.lds &> /dev/null
rm arch/arm64/kernel/vdso/vdso.so &> /dev/null
rm arch/arm64/kernel/vdso/vdso.so.dbg &> /dev/null
rm arch/arm64/kernel/vmlinux.lds &> /dev/null
rm security/samsung/defex_lsm/cert/pubkey_eng.der &> /dev/null
rm security/samsung/defex_lsm/cert/pubkey_user.der &> /dev/null
rm security/samsung/defex_lsm/defex_packed_rules.bin &> /dev/null

############################################################# exports
export ARCH=arm64
export CROSS_COMPILE=../toolchain/bin/aarch64-linux-gnu-
export USE_CCACHE=1
## this works for pp aswell
export ANDROID_MAJOR_VERSION=q

read -p -r "Enter defconfig name: " defconfig
read -p -r "Enter android build version: " major

############################################################# b1g memes here W.I.P
if [ "$defconfig" == "exynos7870-j7xelte_defconfig" ]; then
read -p -r "Non Treble AOSP(1) or Treble AOSP(2) or OneUI(3) or Treble OneUI(4): " type

elif [ "$defconfig" == "exynos7870-gtaxllte_defconfig" ]; then
read -p -r "Non Treble AOSP(1) or Treble AOSP(2) or OneUI(3) or Treble OneUI(4): " type

elif [ "$defconfig" == "exynos7870-gtaxlwifi_defconfig" ]; then
read -p -r "Non Treble AOSP(1) or Treble AOSP(2) or OneUI(3) or Treble OneUI(4): " type

elif [ "$defconfig" == "exynos7870-j7velte_defconfig" ]; then
read -p -r "Non Treble AOSP(1) or Treble AOSP(2) or OneUI(3) or Treble OneUI(4): " type


elif [ "$defconfig" == "exynos7870-on7xelte_defconfig" ]; then
read -p -r "Non Treble AOSP(1) or Treble AOSP(2) or OneUI(3) or Treble OneUI(4): " type


elif [ "$defconfig" == "exynos7870-a3y17lte_defconfig" ]; then
read -p -r "Non Treble AOSP(1) or Treble AOSP(2) or OneUI(3) or Treble OneUI(4): " type


elif [ "$defconfig" == "exynos7870-j5y17lte_defconfig" ]; then
read -p -r "Non Treble AOSP(1) or Treble AOSP(2) or OneUI(3) or Treble OneUI(4): " type


elif [ "$defconfig" == "exynos7870-j7y17lte_defconfig" ]; then
read -p -r "Non Treble AOSP(1) or Treble AOSP(2) or OneUI(3) or Treble OneUI(4): " type


elif [ "$defconfig" == "exynos7870-on7xreflte_defconfig" ]; then
read -p -r "Non Treble AOSP(1) or Treble AOSP(2) or OneUI(3) or Treble OneUI(4): " type


## these don't need dtb change because they are always treble, but they need USB fix for AOSP
elif [ "$defconfig" == "exynos7870-a2corelte_defconfig" ]; then
read -p -r "AOSP(1) or OneUI(3): " type
elif [ "$defconfig" == "exynos7870-a6lte_defconfig" ]; then
read -p -r "AOSP(1) or OneUI(3): " type
elif [ "$defconfig" == "exynos7870-j6lte_defconfig" ]; then
read -p -r "AOSP(1) or OneUI(3): " type
elif [ "$defconfig" == "exynos7870-m10lte_defconfig" ]; then
read -p -r "AOSP(1) or OneUI(3): " type

############################################################# Mali version fix
if [ "$major" == "p" ]; then
export ANDROID_MAJOR_VERSION=p
sed -i 's/CONFIG_DDK_VERSION_OS="q"/"CONFIG_DDK_VERSION_OS="p"/g' arch/arm64/configs/"$defconfig"
sed -i 's/CONFIG_MALI_R29P0=y/CONFIG_MALI_R28P0=y/g' arch/arm64/configs/"$defconfig"

############################################################# Treble USB Fix
if [ "$type" == "1" ]; then
sed -i 's/CONFIG_USB_ANDROID_SAMSUNG_MTP=y/# CONFIG_USB_ANDROID_SAMSUNG_MTP is not set/g' arch/arm64/configs/"$defconfig"
elif [ "$type" == "2" ]; then
sed -i 's/CONFIG_USB_ANDROID_SAMSUNG_MTP=y/# CONFIG_USB_ANDROID_SAMSUNG_MTP is not set/g' arch/arm64/configs/"$defconfig"

############################################################# Build dtb and Image
make "$defconfig"
make exynos7870-j7xelte_eur_open_00.dtb exynos7870-j7xelte_eur_open_01.dtb exynos7870-j7xelte_eur_open_02.dtb exynos7870-j7xelte_eur_open_03.dtb exynos7870-j7xelte_eur_open_04.dtb
./tools/dtbtool arch/arm64/boot/dts/ -o arch/arm64/boot/dtb
make -j"$(nproc)"

############################################################# Treble USB Fix restore
if [ "$type" == "1" ]; then
sed -i 's/# CONFIG_USB_ANDROID_SAMSUNG_MTP is not set/CONFIG_USB_ANDROID_SAMSUNG_MTP=y/g' arch/arm64/configs/"$defconfig"
elif [ "$type" == "2" ]; then
sed -i 's/# CONFIG_USB_ANDROID_SAMSUNG_MTP is not set/CONFIG_USB_ANDROID_SAMSUNG_MTP=y/g' arch/arm64/configs/"$defconfig"

############################################################# Mali version fix restore
if [ "$major" == "p" ]; then
sed -i 's/CONFIG_DDK_VERSION_OS="p"/"CONFIG_DDK_VERSION_OS="q"/g' arch/arm64/configs/"$defconfig"
sed -i 's/CONFIG_MALI_R28P0=y/CONFIG_MALI_R29P0=y/g' arch/arm64/configs/"$defconfig"

############################################################# Make source clean, but leave Image && dtb
echo -e "Cleaning again"
make clean &> /dev/null
make mrproper &> /dev/null
rm arch/arm64/boot/dts/*.dtb &> /dev/null
rm arch/arm64/kernel/vdso/vdso.lds &> /dev/null
rm arch/arm64/kernel/vdso/vdso.so &> /dev/null
rm arch/arm64/kernel/vdso/vdso.so.dbg &> /dev/null
rm arch/arm64/kernel/vmlinux.lds &> /dev/null
rm security/samsung/defex_lsm/cert/pubkey_eng.der &> /dev/null
rm security/samsung/defex_lsm/cert/pubkey_user.der &> /dev/null
rm security/samsung/defex_lsm/defex_packed_rules.bin &> /dev/null
############################################################# end
fi
fi
fi
fi
fi
