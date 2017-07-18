cmake_minimum_required(VERSION 2.8)
project(Terrific)
include(ExternalProject)

set(Terrific_INSTALL_DIR "${Terrific_SOURCE_DIR}/bin")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${Terrific_SOURCE_DIR}/cmake")
set(CMAKE_PREFIX_PATH ${external_DIR})

set(include_DIR "${Terrific_SOURCE_DIR}/include")

set(library_DIR "${Terrific_SOURCE_DIR}/libs")

set(external_DIR "${Terrific_SOURCE_DIR}/external")

ExternalProject_Add(entityx
    PREFIX ${external_DIR}/entityx
    GIT_REPOSITORY https://github.com/alecthomas/entityx.git
    GIT_TAG origin/master
    INSTALL_DIR ${external_DIR}/entityx
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${external_DIR}/entityx
)

ExternalProject_Add(sol2
	PREFIX ${external_DIR}/sol2
	GIT_REPOSITORY https://github.com/ThePhD/sol2.git
	GIT_TAG origin/develop
	INSTALL_DIR ${external_DIR}/sol2
	CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${external_DIR}/sol2
)

set(SDL2_LIBRARY_TEMP "${Terrific_SOURCE_DIR}/external/lib/x86/SDL2.lib")
set(SDL2_INCLUDE_TEMP "${Terrific_SOURCE_DIR}/external/include/SDL2.lib")

#find_package(SDL2 REQUIRED)

if (${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU" OR ${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -pedantic -ggdb -std=c++11")
elseif (${CMAKE_CXX_COMPILER_ID} STREQUAL "MSVC")
    if(CMAKE_CXX_FLAGS MATCHES "/W[0-4]")
        string(REGEX REPLACE "/W[0-4]" "/W4" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /Zi")
    else()
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4 /Zi")
    endif()
endif()

include_directories(include ${include_DIR}/entityx $(SDL2_INCLUDE_DIR))
#target_link_libraries(Terrific ${SDL2_LIBRARY))
