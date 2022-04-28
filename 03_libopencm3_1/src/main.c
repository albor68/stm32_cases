#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/rcc.h>


void delay(unsigned long count);


int main (void) {

     rcc_periph_clock_enable(RCC_GPIOD);
     gpio_mode_setup(GPIOD, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, GPIO13);

     while (1) {
          gpio_toggle(GPIOD, GPIO13);
          delay(1000000);
     }
}


void delay (volatile unsigned long count) {
     while(count--);
}
