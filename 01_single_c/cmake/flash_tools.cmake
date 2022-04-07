set(OOCD_FLASH_SCRIPT
     "MESSAGE(STATUS \"Flashing firmware\")
     execute_process (
          COMMAND openocd
               -f ${CMAKE_SOURCE_DIR}/conf/openocd_discovery.cfg
               -c \"init\" 
               -c \"reset halt\"
               -c \"program ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}\" 
               -c \"reset\"
               -c \"shutdown\"
     )
     MESSAGE(STATUS \"Flashing complete\")
     "
)
