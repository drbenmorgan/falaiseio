#--- CMake Config Files -----------------------------------------------
# - Use CMake's module to help generating relocatable config files
include(CMakePackageConfigHelpers)

# - Versioning
write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/falaiseioConfigVersion.cmake
  VERSION ${falaiseio_VERSION}
  COMPATIBILITY SameMajorVersion)

# - Install time config and target files
configure_package_config_file(${CMAKE_CURRENT_LIST_DIR}/falaiseioConfig.cmake.in
  "${PROJECT_BINARY_DIR}/falaiseioConfig.cmake"
  INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/falaiseio"
  PATH_VARS
    CMAKE_INSTALL_BINDIR
    CMAKE_INSTALL_INCLUDEDIR
    CMAKE_INSTALL_LIBDIR
  )

# - install and export
install(FILES
  "${PROJECT_BINARY_DIR}/falaiseioConfigVersion.cmake"
  "${PROJECT_BINARY_DIR}/falaiseioConfig.cmake"
  DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/falaiseio"
  )
install(EXPORT falaiseioTargets
  NAMESPACE falaiseio::
  DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/falaiseio"
  )

#--- Pkg-Config File --------------------------------------------------
# - Derive relative pcfile -> prefix path to make pkg-config file
#   relocatable
file(RELATIVE_PATH falaiseio_PCFILEDIR_TO_PREFIX
  "${CMAKE_INSTALL_FULL_LIBDIR}/pkgconfig"
  "${CMAKE_INSTALL_PREFIX}"
  )
configure_file("${CMAKE_CURRENT_LIST_DIR}/falaiseio.pc.in"
  "${PROJECT_BINARY_DIR}/falaiseio.pc"
  @ONLY
  )
install(FILES "${PROJECT_BINARY_DIR}/falaiseio.pc"
  DESTINATION "${CMAKE_INSTALL_LIBDIR}/pkgconfig"
  )
