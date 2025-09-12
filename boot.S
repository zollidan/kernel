/* Multiboot header */
.set MAGIC,     0x1BADB002
.set FLAGS,     0
.set CHECKSUM,  -(MAGIC + FLAGS)

.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

/* Точка входа */
.section .text
.global _start
_start:
    cli
    mov $stack_top, %esp      /* простой стек */
    call kmain                /* в C */
.hang:
    hlt
    jmp .hang

/* Стек в .bss */
.section .bss
.align 16
stack:
    .skip 16384               /* 16 KiB */
stack_top:
