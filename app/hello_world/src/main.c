#include <zephyr/kernel.h>

void main(void)
{
    printk("Hello World! qemu_cortex -v2 %s\n", CONFIG_BOARD);
}
