MESSAGE(STATUS "Target MCU settings loading")

set(TARGET_CORE "cortex-m4" CACHE STRING "Ядро центрального процессора" FORCE)
set(TARGET_SERIE "stm32f4" CACHE STRING "Семейство центрального процессора" FORCE)
set(TARGET_LINE "stm32f407" CACHE STRING "Линейка центрального процессора" FORCE)
set(TARGET_MODEL "stm32f407vgt6" CACHE STRING "Модель центрального процессора" FORCE)
set(TARGET_FPU "fpv4-sp-d16" CACHE STRING "Математический сопроцессор" FORCE)
set(TARGET_FLOAT_ABI "hard" CACHE STRING "Реализация вычислений с плавающей точкой" FORCE)
set(TARGET_LD_SCRIPT "stm32_flash.ld" CACHE STRING "Скрипт компоновщика для целевой системы" FORCE)

