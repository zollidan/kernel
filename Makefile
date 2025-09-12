AS      = as
CC      = gcc
LD      = ld
OBJCOPY = objcopy

CFLAGS  = -m32 -ffreestanding -fno-stack-protector -fno-pic -fno-pie \
          -nostdlib -nostartfiles -nodefaultlibs -Wall -Wextra -O2
ASFLAGS = --32
LDFLAGS = -m elf_i386 -T linker.ld -nostdlib

ISO_DIR = iso

all: kernel.bin

boot.o: boot.S
	$(AS) $(ASFLAGS) -o $@ $<

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c -o $@ $<

kernel.bin: boot.o kernel.o linker.ld
	$(LD) $(LDFLAGS) -o $@ boot.o kernel.o

iso: kernel.bin grub.cfg
	rm -rf $(ISO_DIR)
	mkdir -p $(ISO_DIR)/boot/grub
	cp kernel.bin $(ISO_DIR)/boot/
	cp grub.cfg  $(ISO_DIR)/boot/grub/
	grub-mkrescue -o tiny-kernel.iso $(ISO_DIR)

run: iso
	qemu-system-i386 -cdrom tiny-kernel.iso

clean:
	rm -f *.o kernel.bin tiny-kernel.iso
	rm -rf $(ISO_DIR)

.PHONY: all iso run clean
