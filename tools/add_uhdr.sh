#!/bin/bash

# $1: image name
# $2: source image
# $3: output image
# $4: load address    (optional)
# $5: execute address (optional)

NAME="$1"
SRC="$2"
OUTPUT="$3"
ARCH="$4"
LADDR=$5
RADDR=$6


####################
# check if mkimage is available?
MKIMAGE="${MKIMAGE:=./boot/uboot/tools/mkimage}"   # Only our mkimage supports quickboot
TYPE=quickboot

function usage()
{
	echo "Usage:"
	echo "$0 image_name source_image output_image [load_addr] [exec_addr]"
}

#NAME=uboot
#SRC=u-boot.bin
#OUTPUT=u-boot.img

#LADDR=0x08100000
#RADDR=$LADDR

##################
# Check arguments

if [ -z "$NAME" ];then
	echo "Missed arg1: name"
	usage
	exit 1
fi

if [ -z "$SRC" ];then
	echo "Missed arg2: source image"
	usage
	exit 1
fi

if [ -z "$OUTPUT" ];then
	echo "Missed arg3: output image"
	usage
	exit 1
fi

if [ -z "$ARCH" ];then
	echo "Missed arg4: cpu type"
	usage
	exit 1
fi

if [ -z "$LADDR" ];then
	LADDR=0
fi

if [ -z "$RADDR" ];then
	RADDR=0
fi


if [ ! -f "$SRC" ];then
	echo "Not found source image: $SRC"
	exit 1
fi

$MKIMAGE -A $ARCH -O linux -T $TYPE -C none -a $LADDR -e $RADDR -n $NAME -d $SRC $OUTPUT

ls -l $OUTPUT
