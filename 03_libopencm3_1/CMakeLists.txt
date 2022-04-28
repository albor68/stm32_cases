#================================================================================
cmake_minimum_required(VERSION 3.22)

set(CMAKE_TOOLCHAIN_FILE cmake/arm-none-eabi-gcc.cmake CACHE FILEPATH "" FORCE)


#================================================================================
project(libopencm3_embedded LANGUAGES C)

include(flash_tools)


#================================================================================
add_executable(${PROJECT_NAME}
     src/main.c
)

target_include_directories(${PROJECT_NAME} PRIVATE
     src
)

target_link_libraries(${PROJECT_NAME}
     ${CMAKE_SOURCE_DIR}/src/libopencm3_stm32f4.a
)

target_link_options(${PROJECT_NAME} PRIVATE
     -T${CMAKE_SOURCE_DIR}/conf/${TARGET_LD_SCRIPT}
     $<$<CONFIG:Debug>:-Wl,-Map=${PROJECT_NAME}.map,--cref>
)

target_compile_definitions(${PROJECT_NAME} PRIVATE
     -D${TARGET_LIBOPENCM3_DEFINE}
)

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
     COMMAND arm-none-eabi-objdump -d ${PROJECT_NAME} > ${PROJECT_NAME}.lst
)


#================================================================================
install(CODE
     ${OOCD_FLASH_SCRIPT}
)
