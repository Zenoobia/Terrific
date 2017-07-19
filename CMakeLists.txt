cmake_minimum_required(VERSION 2.8)
project(Terrific)
include(ExternalProject)

set(Terrific_INSTALL_DIR "${Terrific_SOURCE_DIR}/bin")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${Terrific_SOURCE_DIR}/cmake")
set(CMAKE_PREFIX_PATH ${external_DIR})
set(INSTALL_BIN_DIR ${Terrific_INSTALL_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${Terrific_INSTALL_DIR}")

set(include_DIR "${Terrific_SOURCE_DIR}/include")
set(library_DIR "${Terrific_SOURCE_DIR}/libs")
set(external_DIR "${Terrific_SOURCE_DIR}/external")

execute_process(COMMAND git submodule add "https://github.com/SFML/SFML.git" "${external_DIR}/SFML")
execute_process(COMMAND git submodule add "https://github.com/glfw/glfw.git" "${external_DIR}/glfw")


execute_process(COMMAND git submodule update --init -- "${external_DIR}/SFML" ${Terrific_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR})
add_subdirectory("${external_DIR}/SFML")
set(SFML_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/external/SFML/include")
message(${CMAKE_CURRENT_SOURCE_DIR})

#find_package(SFML COMPONENTS graphics window system)

set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
add_subdirectory("${external_DIR}/glfw")

add_subdirectory("${external_DIR}/lua")

include_directories(include ${LUA_INCLUDE} "${external_DIR}/lua/src" "${external_DIR}/sol2" ${glfw_INCLUDE_DIRS} ${include_DIR}/entityx ${include_DIR} ${SFML_INCLUDE_DIR} ${Terrific_SOURCE_DIR}/src)
add_subdirectory("${Terrific_SOURCE_DIR}/src")


if (${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU" OR ${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -pedantic -ggdb -std=c++11")
elseif (${CMAKE_CXX_COMPILER_ID} STREQUAL "MSVC")
    if(CMAKE_CXX_FLAGS MATCHES "/W[0-4]")
        string(REGEX REPLACE "/W[0-4]" "/W4" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /Zi")
    else()
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4 /Zi")
    endif()
endif()

# ${SFML_LIBRARIES} sfml-system sfml-window sfml-graphics sfml-main)
