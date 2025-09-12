#include <stdint.h>

typedef unsigned int size_t;

static volatile uint16_t* const VGA = (uint16_t*)0xB8000;
static const uint8_t DEFAULT_ATTR = 0x0F; // белый на чёрном

static void vga_clear(void) {
    for (size_t i = 0; i < 80u*25u; ++i) {
        VGA[i] = ((uint16_t)DEFAULT_ATTR << 8) | ' ';
    }
}

static void puts(const char* s) {
    size_t pos = 0;
    while (*s) {
        if (*s == '\n') {
            pos = (pos/80u + 1u) * 80u;
        } else {
            VGA[pos++] = ((uint16_t)DEFAULT_ATTR << 8) | (uint8_t)(*s);
        }
        ++s;
        if (pos >= 80u*25u) pos = 0; 
    }
}

void kmain(void) {
    vga_clear();
    puts("Hello from a tiny kernel!\n");
    puts("No libc, no runtime. Just C + ASM.\n");
    for (;;)
        __asm__ __volatile__("hlt");
}
