#--- add version files ---------------------------------------------------------
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/falaiseioVersion.h.in
               ${CMAKE_CURRENT_BINARY_DIR}/falaiseioVersion.h )
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/falaiseioVersion.h
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/falaiseio )


# List sources for target
# - Note that we include headers. CMake will resolve dependencies on headers
#   correctly, but they will not show up in IDEs like Xcode if they are not
#   listed in the files for a target
set(falaiseio_SOURCES
  falaiseioVersion.h.in
  Example.h
  Example.cpp
  )

## create a library target
add_library(falaiseio SHARED ${falaiseio_SOURCES})

# - Define its header interface when building and when installed
# (i.e. used by a third party)
target_include_directories(falaiseio
  PUBLIC
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
    $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    )

## if needed, link against "someexternal"
## which has been included with find_package(someexternal)
#target_link_libraries(falaiseio ${someexternal_LIBRARIES})

# - Install the example library into the install time library directory
# The EXPORT name is used so that we can "export" the target for
# use by client projects
install(TARGETS falaiseio
  EXPORT falaiseioTargets
  DESTINATION ${CMAKE_INSTALL_LIBDIR}
  )

## install the headers
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  FILES_MATCHING PATTERN "*.h"
  PATTERN "tests" EXCLUDE
  )

# - If testing is required, recurse into the directory holding them
# Note: The BUILD_TESTING variable is set by the inclusion of the CTest
#       Module (done in the root CMake script for the project). It's set
#       as a CMake option that's ON by default, but may be toggled by
#       a cmake-time command line option or through the CMake curses/GUI.
if(BUILD_TESTING)
  add_subdirectory(tests)
endif()

