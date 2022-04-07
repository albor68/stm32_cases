/* Minimal linker script for stm32f4xx */
ENTRY(main)


/* Simplified memory layout */
MEMORY {
     FLASH     (rx)     :     ORIGIN = 0x08000000, LENGTH = 1024K     /* Main Embedded FlashROM */
     SRAM      (xrw)    :     ORIGIN = 0x20000000, LENGTH = 112K      /* Main Embedded SRAM */
}


/* Code output sections */
SECTIONS {
     /* Program code into FLASH */
     .text : ALIGN(4) {
          FILL(0xFF)
          KEEP(*(.isr_vector))
          *(.text.*)
          *(.rodata .rodata.*)
     } >FLASH
 
     /* Program data (which we don't have any in this example) into SRAM */
     .data : ALIGN(4) {
          *(.data)            
     } >SRAM AT>FLASH = 0xFF
}
