#================================================================================
cmake_minimum_required(VERSION 3.22)

set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_LIST_DIR}/cmake/arm-none-eabi-gcc-wolibc.cmake CACHE FILEPATH "" FORCE)


#================================================================================
project(single_c LANGUAGES C)

include(flash_tools)


#================================================================================
add_executable(${PROJECT_NAME}
     src/main.c
)

target_link_options(${PROJECT_NAME} PRIVATE
     -T${CMAKE_SOURCE_DIR}/conf/stm32f4_minimal.ld
)


#================================================================================
install(CODE
     ${OOCD_FLASH_SCRIPT}
)
