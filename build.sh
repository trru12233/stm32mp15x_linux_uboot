#!/bin/bash
if [ -f envsetup.sh ];then
    source envsetup.sh
else
    echo "cannot find envsetup.sh"
    exit 0
fi
echo "******************************"
echo "KERNEL_DEFCONFIG=$UBOOT_DEFCONFIG"
echo "BUILD_OUTPUT_PATH=$BUILD_OUTPUT_PATH"
echo "******************************"

if [ -f u-boot.stm32 ];then
    rm u-boot.stm32
fi

make $UBOOT_DEFCONFIG O=${BUILD_OUTPUT_PATH} -j${N}
echo "******************************"

# creat uboot.stm32
runcmd "make all O=${BUILD_OUTPUT_PATH} DEVICE_TREE=stm32mp157d-atk -j${N}"
# copy uboot.stm32 to current folder
cpfiles ${BUILD_OUTPUT_PATH}/u-boot.stm32 ./

echo "******************************"
echo "       build uboot OK !!!"
echo "******************************"
echo ">>File: u-boot.stm32= `ls -lh u-boot.stm32 | awk '{print $5}'`"