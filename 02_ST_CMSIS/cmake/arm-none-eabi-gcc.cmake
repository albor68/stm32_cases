list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/target_mcu.cmake")
     include(target_mcu)
endif()


if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Конфигурация сборки по умолчанию: Debug" FORCE)
endif()

set(CMAKE_SYSTEM_NAME  Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

if (NOT TARGET_CORE)
    set(TARGET_CORE "cortex-m4" CACHE STRING "Ядро центрального процессора")
endif()

if (NOT TARGET_FPU)
    set(TARGET_FPU "fpv4-sp-d16" CACHE STRING "Математический сопроцессор")
endif()

if (NOT TARGET_FLOAT_ABI)
    set(TARGET_FLOAT_ABI "hard" CACHE STRING "Реализация вычислений с плавающей точкой")
endif()


if(MINGW OR CYGWIN OR WIN32)
    set(UTIL_SEARCH_CMD where)
elseif(UNIX OR APPLE)
    set(UTIL_SEARCH_CMD which)
endif()

set(TOOLCHAIN_PREFIX arm-none-eabi-)

execute_process(
  COMMAND ${UTIL_SEARCH_CMD} ${TOOLCHAIN_PREFIX}gcc
  OUTPUT_VARIABLE BINUTILS_PATH
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

get_filename_component(ARM_TOOLCHAIN_DIR ${BINUTILS_PATH} DIRECTORY)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})


set(CMAKE_FIND_ROOT_PATH ${BINUTILS_PATH})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)


# Настройки компилятора
add_compile_options(
     -mcpu=${TARGET_CORE}
     -mthumb
     -mfpu=${TARGET_FPU}
     -mfloat-abi=${TARGET_FLOAT_ABI}

     -fdata-sections
     -ffunction-sections

     $<$<CONFIG:Debug>:-Og>
)


# Настройки компоновщика
add_link_options(
     -mcpu=${TARGET_CORE}
     -mthumb
     -mfpu=${TARGET_FPU}
     -mfloat-abi=${TARGET_FLOAT_ABI}

     -specs=nano.specs
     -lc
     -lm
     -lnosys

     -Wl,--gc-sections
)
