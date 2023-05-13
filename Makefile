ifeq (${KERNELRELEASE},)

# We are being compiled as a module: use the Kernel build system

KERNEL_SOURCE := /usr/src/linux-headers-$(shell uname -r)
PWD := $(shell pwd)

default: module hello

module:
        ${MAKE} -C ${KERNEL_SOURCE} SUBDIRS=${PWD} modules

clean:
        ${MAKE} -C ${KERNEL_SOURCE} SUBDIRS=${PWD} clean

else

# KERNELRELEASE defined: we are being compiled as part of the Kernel
obj-m := servo_control.o

endif

hello: hello.c usbkeyboard.c usbkeyboard.h
        cc -o hello hello.c usbkeyboard.c -lusb-1.0 -lm -lrt -pthread

.PHONY: clean

clean:
        ${RM} hello
