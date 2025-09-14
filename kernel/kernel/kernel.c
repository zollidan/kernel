#include <stdio.h>

#include <kernel/tty.h>
#include <kernel/microshell.h>

void kernel_main(void) {
	terminal_initialize();
	printf("RokitOS started\n");
	run_shell();
}
