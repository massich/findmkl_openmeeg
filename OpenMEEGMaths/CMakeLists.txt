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

target_include_directories(OpenMEEGMaths PUBLIC include)
target_include_directories(OpenMEEGMaths PRIVATE src)

target_link_libraries(OpenMEEGMaths PUBLIC ${LAPACK_LIBRARIES})
target_link_libraries(OpenMEEGMaths PUBLIC MATIO::MATIO)
target_include_directories(OpenMEEGMaths PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_include_directories(OpenMEEGMaths PUBLIC ${CMAKE_CURRENT_BINARY_DIR})
target_include_directories(OpenMEEGMaths PUBLIC ${CMAKE_BINARY_DIR})
target_include_directories(OpenMEEGMaths PUBLIC ${BLA_INCLUDE_DIR})  # XXX : this should become PRIVATE !
target_include_directories(OpenMEEGMaths PRIVATE ${matio_INCLUDE_DIRS})
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
