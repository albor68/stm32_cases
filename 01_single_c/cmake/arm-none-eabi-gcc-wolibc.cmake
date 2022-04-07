list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/target_mcu.cmake")
     include(target_mcu)
endif()


if(NOT CMAKE_BUILD_TYPE)
     set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Default build type: Debug" FORCE)
endif()

set(CMAKE_SYSTEM_NAME  Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

if (NOT TARGET_CORE)
     set(TARGET_CORE "cortex-m4" CACHE STRING "Target CPU core")
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


# Compiler options
add_compile_options(
     -mcpu=${TARGET_CORE}
     -mthumb

     -fdata-sections
     -ffunction-sections

     $<$<CONFIG:Debug>:-Og>
)

# Linker options
add_link_options(
     -nostartfiles
     -nodefaultlibs
     -nostdlib
     
     -Wl,--gc-sections
)
