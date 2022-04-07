// Memory and peripheral start addresses
#define FLASH_BASE      0x08000000
#define SRAM_BASE       0x20000000
#define PERIPH_BASE     0x40000000

// End of RAM address as initial stack pointer
#define SRAM_SIZE       112*1024
#define SRAM_END        (SRAM_BASE + SRAM_SIZE)

// Peripherals base addresses
#define RCC_BASE        (PERIPH_BASE + 0x23800)
#define GPIOD_BASE      (PERIPH_BASE + 0x20C00)
 
// RCC peripheral address applicable to GPIOD
#define RCC_AHB1ENR     (*(volatile unsigned long*)(RCC_BASE + 0x30))
// GPIOD peripheral addresses
#define GPIOD_MODER     (*(volatile unsigned long*)(GPIOD_BASE + 0x00))
#define GPIOD_ODR      (*(volatile unsigned long*)(GPIOD_BASE + 0x14))


// Function prototypes
int main(void);
void delay(unsigned long count);


// ISR vector table
unsigned long* vector_table[] __attribute__((section(".isr_vector"))) = {
    (unsigned long*)SRAM_END,   // initial stack pointer 
    (unsigned long*)main        // main function starts immediately
};


int main () {
    // GPIOD enable clock
    RCC_AHB1ENR |= 0x08;
    // set PD15 pin output mode
    GPIOD_MODER |= 0x40000000;
 
    while (1) {
        GPIOD_ODR ^= 0x8000;  // toggle PD15 pin
        delay(1000000);
    }
}


// Repetition count based delay
void delay (volatile unsigned long count) {
    while(count--);
}
