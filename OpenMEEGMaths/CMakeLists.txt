# OpenMEEGMath
add_library(OpenMEEGMaths SHARED
  src/utils.cpp
  src/vector.cpp
  src/matrix.cpp
  src/symmatrix.cpp
  src/sparse_matrix.cpp
  src/fast_sparse_matrix.cpp
  src/MathsIO.C
  src/MatlabIO.C
  src/AsciiIO.C
  src/BrainVisaTextureIO.C
  src/TrivialBinIO.C
)

target_include_directories(OpenMEEGMaths
      PUBLIC
          include
          ${BLA_INCLUDE_DIR} # XXX : this should not be here, transitive properties should work
          MATIO::MATIO
          ${CMAKE_CURRENT_SOURCE_DIR}/include
          ${CMAKE_CURRENT_BINARY_DIR}
          ${CMAKE_BINARY_DIR}
      PRIVATE
          src
          ${matio_INCLUDE_DIRS} # XXX : this should become transitive prop.
)

target_link_libraries(OpenMEEGMaths
      PUBLIC # XXX : this should become PRIVATE !
          ${LAPACK_LIBRARIES}
          MATIO::MATIO
)

target_compile_definitions(OpenMEEGMaths PUBLIC ${BLA_DEFINITIONS})
add_library(OpenMEEG::OpenMEEGMaths ALIAS OpenMEEGMaths)

generate_export_header(OpenMEEGMaths
    EXPORT_FILE_NAME OpenMEEGMaths_Export.h
    STATIC_DEFINE OpenMEEGMaths_BUILT_AS_STATIC)

# create_library(OpenMEEGMaths ${OpenMEEGMaths_SOURCES})

# 'make install' to the correct locations (provided by GNUInstallDirs).
install(TARGETS OpenMEEGMaths EXPORT OpenMEEGConfig
    ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR})  # This is for Windows
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})


############################################################

# This are executables using OpenMEEGMath
add_subdirectory(tests)
add_subdirectory(apps)
