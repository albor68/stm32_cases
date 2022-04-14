#include "stm32f4xx.h"


void delay(unsigned long count);


int main () {
     // enable clock on GPIOD peripheral
     RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;
     // set PD14 pin output mode
     GPIOD->MODER |= GPIO_MODER_MODER14_0;
 
     while (1) {
          GPIOD->ODR ^= GPIO_ODR_OD14;  // toggle PD14 pin
          delay(1000000);
     }
}


void delay (volatile unsigned long count) {
     while(count--);
}
