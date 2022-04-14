#================================================================================
cmake_minimum_required(VERSION 3.22)

set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_LIST_DIR}/cmake/arm-none-eabi-gcc.cmake CACHE FILEPATH "" FORCE)


#================================================================================
project(st_cmsis LANGUAGES C ASM)

include(flash_tools)


#================================================================================
add_executable(${PROJECT_NAME}
     src/main.c
     src/startup_stm32f407xx.s
     src/system_stm32f4xx.c
)

target_link_options(${PROJECT_NAME} PRIVATE
     -T${CMAKE_SOURCE_DIR}/conf/stm32_flash.ld
)

target_compile_definitions(${PROJECT_NAME} PRIVATE
     -DSTM32F407xx
)


#================================================================================
install(CODE
     ${OOCD_FLASH_SCRIPT}
)
