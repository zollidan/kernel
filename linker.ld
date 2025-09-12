ENTRY(_start)

SECTIONS
{
  /* Грузим ядро по адресу 1 MiB (классика для GRUB/Multiboot) */
  . = 1M;

  .multiboot : { *(.multiboot) }

  .text : { *(.text*) }

  .rodata : { *(.rodata*) }

  .data : { *(.data*) }

  .bss : {
    *(.bss*)
    *(COMMON)
  }
}
