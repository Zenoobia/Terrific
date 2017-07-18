cmake_minimum_required(VERSION 2.8)
project(Terrific)
include(ExternalProject)

set(Terrific_INSTALL_DIR "${Terrific_SOURCE_DIR}/bin")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${Terrific_SOURCE_DIR}/cmake")
set(CMAKE_PREFIX_PATH ${external_DIR})

set(include_DIR "${Terrific_SOURCE_DIR}/include")
set(library_DIR "${Terrific_SOURCE_DIR}/libs")
set(external_DIR "${Terrific_SOURCE_DIR}/external")


add_subdirectory("${external_DIR}/SFML" )

execute_process(COMMAND git submodule update --init external/SFML ${Terrific_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR})
set(SFML_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/external/SFML/include" CACHE PATH "SFML include directory")
message(${SFML_INCLUDE_DIR})
#find_package(SFML)

if (${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU" OR ${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -pedantic -ggdb -std=c++11")
elseif (${CMAKE_CXX_COMPILER_ID} STREQUAL "MSVC")
    if(CMAKE_CXX_FLAGS MATCHES "/W[0-4]")
        string(REGEX REPLACE "/W[0-4]" "/W4" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /Zi")
    else()
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4 /Zi")
    endif()
endif()

include_directories(include ${include_DIR}/entityx $(SFML_INCLUDE_DIR))
#target_link_libraries(Terrific ${SDL2_LIBRARY))
