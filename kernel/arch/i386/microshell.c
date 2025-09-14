#include <stdbool.h>

#include <kernel/microshell.h>
#include <kernel/tty.h>

void run_shell(void) {
  terminal_putchar('>');
  terminal_putchar(' ');
}