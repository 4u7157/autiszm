#!/bin/bash

echo -e "Cleaning"
make clean &> /dev/null
make mrproper &> /dev/null
rm -rf output/
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

read -p "Enter defconfig name: " defconfig
read -p "Enter android build version (type p even if Q AOSP Build): " major
read - p "AOSP? (y or n)" aosp
############################################################# b1g memes here W.I.P
if [ "$defconfig" == "exynos7870-j7xelte_defconfig" ]; then
read -p "Non Treble (1) or Treble(2): " type1
dtbname="exynos7870-j7xelte_common.dtsi"

dtbfiles="exynos7870-j7xelte_eur_open_00.dtb exynos7870-j7xelte_eur_open_01.dtb exynos7870-j7xelte_eur_open_02.dtb exynos7870-j7xelte_eur_open_03.dtb exynos7870-j7xelte_eur_open_04.dtb"

elif [ "$defconfig" == "exynos7870-gtaxllte_defconfig" ]; then
read -p "Non Treble (1) or Treble(2): " type2
dtbname="exynos7870-gtaxl_common.dtsi"

elif [ "$defconfig" == "exynos7870-gtaxlwifi_defconfig" ]; then
read -p "Non Treble (1) or Treble(2): " type2
dtbname="exynos7870-gtaxl_common.dtsi"

elif [ "$defconfig" == "exynos7870-j7velte_defconfig" ]; then
read -p "Non Treble (1) or Treble(2): " type
dtbname="exynos7870-j7velte_common.dtsi"

elif [ "$defconfig" == "exynos7870-on7xelte_defconfig" ]; then
read -p "Non Treble (1) or Treble(2): " type1
dtbname="exynos7870-on7xelte_common.dtsi"

elif [ "$defconfig" == "exynos7870-a3y17lte_defconfig" ]; then
read -p "Non Treble (1) or Treble(2): " type2
dtbname="exynos7870-a3y17lte_common.dtsi"

elif [ "$defconfig" == "exynos7870-j5y17lte_defconfig" ]; then
read -p "Non Treble (1) or Treble(2): " type
dtbname="exynos7870-j5y17lte_common.dtsi"

elif [ "$defconfig" == "exynos7870-j7y17lte_defconfig" ]; then
read -p "Non Treble (1) or Treble(2): " type
dtbname="exynos7870-j7y17lte_common.dtsi"

elif [ "$defconfig" == "exynos7870-on7xreflte_defconfig" ]; then
read -p "Non Treble (1) or Treble(2): " type
dtbname="exynos7870-on7xreflte_common.dtsi"

## these don't need dtb change because they are always treble
elif [ "$defconfig" == "exynos7870-a2corelte_defconfig" ]; then
dtbfiles="## fix later"
elif [ "$defconfig" == "exynos7870-a6lte_defconfig" ]; then
dtbfiles="exynos7870-a6lte_eur_open_00.dtb exynos7870-a6lte_eur_open_01.dtb exynos7870-a6lte_eur_open_02.dtb exynos7870-a6lte_eur_open_03.dtb"
elif [ "$defconfig" == "exynos7870-j6lte_defconfig" ]; then
dtbfile="## fix later"
elif [ "$defconfig" == "exynos7870-m10lte_defconfig" ]; then
dtbfiles="exynos7870-m10lte_swa_open_00.dtb exynos7870-m10lte_swa_open_01.dtb exynos7870-m10lte_swa_open_02.dtb exynos7870-m10lte_swa_open_03.dtb exynos7870-m10lte_swa_open_04.dtb"
fi


## dtb regex

## type 1

## variant 1 (j710 g610 oneui, nontreble aosp)
if [ "$type1" == "1" ]; then
sed -i 's/	firmware {\n	   android {\n		 compatible = "android,firmware";\n		  fstab {\n			 compatible = "android,fstab";\n			 system {\n				  compatible = "android,system";\n				  dev = "\/dev\/block\/platform\/13540000\.dwmmc0\/by-name\/SYSTEM";\n				  type = "ext4";\n				  mnt_flags = "ro";\n				  fsmgr_flags = "wait";\n				 };\n		   };\n	  };\n	};\n\n	reserved-memory {/	reserved-memory {/g' arch/arm64/boot/"$dtbname"
## variant 2 (j710 g610 oneui treble, treble aosp)
elif [ "$type1" == "2" ]; then
sed -i 's/	firmware {\n	   android {\n		 compatible = "android,firmware";\n		  fstab {\n			 compatible = "android,fstab";\n			 system {\n				  compatible = "android,system";\n				  dev = "\/dev\/block\/platform\/13540000\.dwmmc0\/by-name\/SYSTEM";\n				  type = "ext4";\n				  mnt_flags = "ro";\n				  fsmgr_flags = "wait";\n				 };\n		   };\n	  };\n	};/	firmware {\n	   android {\n		 compatible = "android,firmware";\n		  fstab {\n			 compatible = "android,fstab";\n			 system {\n				  compatible = "android,system";\n				  dev = "\/dev\/block\/platform\/13540000\.dwmmc0\/by-name\/SYSTEM";\n				  type = "ext4";\n				  mnt_flags = "ro";\n				  fsmgr_flags = "wait";\n				 };\n			 vendor {\n				  compatible = "android,vendor";\n				  dev = "\/dev\/block\/platform\/13540000\.dwmmc0\/by-name\/VENDOR";\n				  type = "ext4";\n				  mnt_flags = "ro";\n				  fsmgr_flags = "wait";\n				 };\n		   };\n	  };\n	};/g' arch/arm64/boot/"$dtbname"
fi
## type 2 (missing mount)

if [ "$type2" == "2" ]; then
sed -i 's/	reserved-memory {/	firmware {\n	   android {\n		 compatible = "android,firmware";\n		  fstab {\n			 compatible = "android,fstab";\n			 system {\n				  compatible = "android,system";\n				  dev = "\/dev\/block\/platform\/13540000\.dwmmc0\/by-name\/SYSTEM";\n				  type = "ext4";\n				  mnt_flags = "ro";\n				  fsmgr_flags = "wait";\n				 };\n			 vendor {\n				  compatible = "android,vendor";\n				  dev = "\/dev\/block\/platform\/13540000\.dwmmc0\/by-name\/VENDOR";\n				  type = "ext4";\n				  mnt_flags = "ro";\n				  fsmgr_flags = "wait";\n				 };\n		   };\n	  };\n	};\n\n	reserved-memory {/g' arch/arm64/boot/"$dtbname"

## type 3 (treble only)
if [ "$type" == "2" ]; then
sed -i 's/	firmware {\n	   android {\n		 compatible = "android,firmware";\n		  fstab {\n			 compatible = "android,fstab";\n			 system {\n				  compatible = "android,system";\n				  dev = "\/dev\/block\/platform\/13540000\.dwmmc0\/by-name\/SYSTEM";\n				  type = "ext4";\n				  mnt_flags = "ro";\n				  fsmgr_flags = "wait";\n				 };\n		   };\n	  };\n	};/	firmware {\n	   android {\n		 compatible = "android,firmware";\n		  fstab {\n			 compatible = "android,fstab";\n			 system {\n				  compatible = "android,system";\n				  dev = "\/dev\/block\/platform\/13540000\.dwmmc0\/by-name\/SYSTEM";\n				  type = "ext4";\n				  mnt_flags = "ro";\n				  fsmgr_flags = "wait";\n				 };\n			 vendor {\n				  compatible = "android,vendor";\n				  dev = "\/dev\/block\/platform\/13540000\.dwmmc0\/by-name\/VENDOR";\n				  type = "ext4";\n				  mnt_flags = "ro";\n				  fsmgr_flags = "wait";\n				 };\n		   };\n	  };\n	};/g' arch/arm64/boot/"$dtbname"

############################################################# Mali version fix
if [ "$major" == "p" ]; then
sed -i 's/CONFIG_DDK_VERSION_OS="q"/"CONFIG_DDK_VERSION_OS="p"/g' arch/arm64/configs/"$defconfig"
sed -i 's/CONFIG_MALI_R29P0=y/CONFIG_MALI_R28P0=y/g' arch/arm64/configs/"$defconfig"

############################################################# Treble USB Fix
if [ "$aosp" == "y" ]; then
sed -i 's/CONFIG_USB_ANDROID_SAMSUNG_MTP=y/# CONFIG_USB_ANDROID_SAMSUNG_MTP is not set/g' arch/arm64/configs/"$defconfig"

############################################################# Build dtb and Image
make "$defconfig"
make "$dtbfiles"
./tools/dtbtool arch/arm64/boot/dts/ -o arch/arm64/boot/dtb
make -j"$(nproc)"

############################################################# Treble USB Fix restore
if [ "$aosp" == "y" ]; then
sed -i 's/# CONFIG_USB_ANDROID_SAMSUNG_MTP is not set/CONFIG_USB_ANDROID_SAMSUNG_MTP=y/g' arch/arm64/configs/"$defconfig"
fi
############################################################# Mali version fix restore
if [ "$major" == "p" ]; then
sed -i 's/CONFIG_DDK_VERSION_OS="p"/"CONFIG_DDK_VERSION_OS="q"/g' arch/arm64/configs/"$defconfig"
sed -i 's/CONFIG_MALI_R28P0=y/CONFIG_MALI_R29P0=y/g' arch/arm64/configs/"$defconfig"

############################################################# Make source clean, but leave Image && dtb
echo -e "Cleaning again"
mkdir output/
mv arch/arm64/boot/Image output/
mv arch/arm64/boot/dtb output/
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

############################################################# dtb regex revert

## variant 1 (j710 g610 oneui, nontreble aosp) revert
if [ "$type1" == "1" ]; then
sed -i 's/	reserved-memory {/	firmware {\n	   android {\n		 compatible = "android,firmware";\n		  fstab {\n			 compatible = "android,fstab";\n			 system {\n				  compatible = "android,system";\n				  dev = "\/dev\/block\/platform\/13540000\.dwmmc0\/by-name\/SYSTEM";\n				  type = "ext4";\n				  mnt_flags = "ro";\n				  fsmgr_flags = "wait";\n				 };\n		   };\n	  };\n	};\n\n	reserved-memory {/g' arch/arm64/boot/"$dtbname"
## variant 2 (j710 g610 oneui treble, treble aosp) revert
elif [ "$type1" == "2" ]; then
sed -i 's/	firmware {\n	   android {\n		 compatible = "android,firmware";\n		  fstab {\n			 compatible = "android,fstab";\n			 system {\n				  compatible = "android,system";\n				  dev = "\/dev\/block\/platform\/13540000\.dwmmc0\/by-name\/SYSTEM";\n				  type = "ext4";\n				  mnt_flags = "ro";\n				  fsmgr_flags = "wait";\n				 };\n			 vendor {\n				  compatible = "android,vendor";\n				  dev = "\/dev\/block\/platform\/13540000\.dwmmc0\/by-name\/VENDOR";\n				  type = "ext4";\n				  mnt_flags = "ro";\n				  fsmgr_flags = "wait";\n				 };\n		   };\n	  };\n	};/	firmware {\n	   android {\n		 compatible = "android,firmware";\n		  fstab {\n			 compatible = "android,fstab";\n			 system {\n				  compatible = "android,system";\n				  dev = "\/dev\/block\/platform\/13540000\.dwmmc0\/by-name\/SYSTEM";\n				  type = "ext4";\n				  mnt_flags = "ro";\n				  fsmgr_flags = "wait";\n				 };\n		   };\n	  };\n	};/g' arch/arm64/boot/"$dtbname"



## type 2 (missing mount) revert

if [ "$type2" == "2" ]; then
sed -i 's/	firmware {\n	   android {\n		 compatible = "android,firmware";\n		  fstab {\n			 compatible = "android,fstab";\n			 system {\n				  compatible = "android,system";\n				  dev = "\/dev\/block\/platform\/13540000\.dwmmc0\/by-name\/SYSTEM";\n				  type = "ext4";\n				  mnt_flags = "ro";\n				  fsmgr_flags = "wait";\n				 };\n			 vendor {\n				  compatible = "android,vendor";\n				  dev = "\/dev\/block\/platform\/13540000\.dwmmc0\/by-name\/VENDOR";\n				  type = "ext4";\n				  mnt_flags = "ro";\n				  fsmgr_flags = "wait";\n				 };\n		   };\n	  };\n	};\n\n	reserved-memory {/	reserved-memory {/g' arch/arm64/boot/"$dtbname"

## type 3 (treble only) revert

if [ "$type" == "2" ]; then
sed -i 's/	firmware {\n	   android {\n		 compatible = "android,firmware";\n		  fstab {\n			 compatible = "android,fstab";\n			 system {\n				  compatible = "android,system";\n				  dev = "\/dev\/block\/platform\/13540000\.dwmmc0\/by-name\/SYSTEM";\n				  type = "ext4";\n				  mnt_flags = "ro";\n				  fsmgr_flags = "wait";\n				 };\n			 vendor {\n				  compatible = "android,vendor";\n				  dev = "\/dev\/block\/platform\/13540000\.dwmmc0\/by-name\/VENDOR";\n				  type = "ext4";\n				  mnt_flags = "ro";\n				  fsmgr_flags = "wait";\n				 };\n		   };\n	  };\n	};/	firmware {\n	   android {\n		 compatible = "android,firmware";\n		  fstab {\n			 compatible = "android,fstab";\n			 system {\n				  compatible = "android,system";\n				  dev = "\/dev\/block\/platform\/13540000\.dwmmc0\/by-name\/SYSTEM";\n				  type = "ext4";\n				  mnt_flags = "ro";\n				  fsmgr_flags = "wait";\n				 };\n		   };\n	  };\n	};/g' arch/arm64/boot/"$dtbname"

############################################################# end
echo "Done, output can be found in output/"
fi
fi
fi
fi
fi
fi
fi
fi
