#!/bin/sh
set -e
. ./build.sh

mkdir -p isodir
mkdir -p isodir/boot
mkdir -p isodir/boot/grub

cp sysroot/boot/rokitos.kernel isodir/boot/rokitos.kernel
cat > isodir/boot/grub/grub.cfg << EOF
menuentry "rokitos" {
	multiboot /boot/rokitos.kernel
}
EOF
grub-mkrescue -o rokitos.iso isodir
