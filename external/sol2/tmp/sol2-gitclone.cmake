if("origin/develop" STREQUAL "")
  message(FATAL_ERROR "Tag for git checkout should not be empty.")
endif()

set(run 0)

if("W:/terrific/external/sol2/src/sol2-stamp/sol2-gitinfo.txt" IS_NEWER_THAN "W:/terrific/external/sol2/src/sol2-stamp/sol2-gitclone-lastrun.txt")
  set(run 1)
endif()

if(NOT run)
  message(STATUS "Avoiding repeated git clone, stamp file is up to date: 'W:/terrific/external/sol2/src/sol2-stamp/sol2-gitclone-lastrun.txt'")
  return()
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E remove_directory "W:/terrific/external/sol2/src/sol2"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to remove directory: 'W:/terrific/external/sol2/src/sol2'")
endif()

set(git_options)

# disable cert checking if explicitly told not to do it
set(tls_verify "")
if(NOT "x" STREQUAL "x" AND NOT tls_verify)
  list(APPEND git_options
    -c http.sslVerify=false)
endif()

set(git_clone_options)

set(git_shallow "")
if(git_shallow)
  list(APPEND git_clone_options --depth 1 --no-single-branch)
endif()

set(git_progress "")
if(git_progress)
  list(APPEND git_clone_options --progress)
endif()

set(git_config "")
foreach(config IN LISTS git_config)
  list(APPEND git_clone_options --config ${config})
endforeach()

# try the clone 3 times incase there is an odd git clone issue
set(error_code 1)
set(number_of_tries 0)
while(error_code AND number_of_tries LESS 3)
  execute_process(
    COMMAND "F:/Program Files/Git/cmd/git.exe" ${git_options} clone ${git_clone_options} --origin "origin" "https://github.com/ThePhD/sol2.git" "sol2"
    WORKING_DIRECTORY "W:/terrific/external/sol2/src"
    RESULT_VARIABLE error_code
    )
  math(EXPR number_of_tries "${number_of_tries} + 1")
endwhile()
if(number_of_tries GREATER 1)
  message(STATUS "Had to git clone more than once:
          ${number_of_tries} times.")
endif()
if(error_code)
  message(FATAL_ERROR "Failed to clone repository: 'https://github.com/ThePhD/sol2.git'")
endif()

execute_process(
  COMMAND "F:/Program Files/Git/cmd/git.exe" ${git_options} checkout origin/develop --
  WORKING_DIRECTORY "W:/terrific/external/sol2/src/sol2"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to checkout tag: 'origin/develop'")
endif()

execute_process(
  COMMAND "F:/Program Files/Git/cmd/git.exe" ${git_options} submodule init 
  WORKING_DIRECTORY "W:/terrific/external/sol2/src/sol2"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to init submodules in: 'W:/terrific/external/sol2/src/sol2'")
endif()

execute_process(
  COMMAND "F:/Program Files/Git/cmd/git.exe" ${git_options} submodule update --recursive --init 
  WORKING_DIRECTORY "W:/terrific/external/sol2/src/sol2"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to update submodules in: 'W:/terrific/external/sol2/src/sol2'")
endif()

# Complete success, update the script-last-run stamp file:
#
execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy
    "W:/terrific/external/sol2/src/sol2-stamp/sol2-gitinfo.txt"
    "W:/terrific/external/sol2/src/sol2-stamp/sol2-gitclone-lastrun.txt"
  WORKING_DIRECTORY "W:/terrific/external/sol2/src/sol2"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to copy script-last-run stamp file: 'W:/terrific/external/sol2/src/sol2-stamp/sol2-gitclone-lastrun.txt'")
endif()

