
file(GLOB SRC "*.h" "*.cpp")

add_executable(terrific ${SRC})
if (WIN32)
	target_link_libraries(terrific sfml-main)
endif (WIN32)

target_link_libraries(terrific ${glfw_LIBRARIES} glfw ${SFML_LIBRARIES} sfml-system sfml-window sfml-graphics)
install(TARGETS terrific
  # IMPORTANT: Add the bar executable to the "export-set"
  RUNTIME DESTINATION "${INSTALL_BIN_DIR}" COMPONENT bin)