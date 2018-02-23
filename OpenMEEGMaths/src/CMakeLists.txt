if (MKL_FOUND AND NOT TARGET dummy_target)
  add_library(dummy_target SHARED utils.cpp)
  target_link_libraries(dummy_target PUBLIC ${LAPACK_LIBRARIES})
  target_include_directories(dummy_target PUBLIC ${BLA_INCLUDE_DIR})
  target_compile_definitions(dummy_target PUBLIC ${BLA_DEFINITIONS})
  target_include_directories(dummy_target PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/../include)
  target_include_directories(dummy_target PUBLIC ${CMAKE_CURRENT_BINARY_DIR})
  target_include_directories(dummy_target PUBLIC ${CMAKE_BINARY_DIR})

  add_library(OpenMEEG::BackEnd ALIAS dummy_target)
endif()

set(OpenMEEGMaths_SOURCES
    utils.cpp vector.cpp matrix.cpp symmatrix.cpp sparse_matrix.cpp fast_sparse_matrix.cpp
    MathsIO.C MatlabIO.C AsciiIO.C BrainVisaTextureIO.C TrivialBinIO.C)

add_library(OpenMEEGMaths SHARED ${OpenMEEGMaths_SOURCES})

# MKL stuff
target_link_libraries(OpenMEEGMaths PUBLIC OpenMEEG::BackEnd)

# MatIO stuff
target_link_libraries(OpenMEEGMaths PUBLIC MATIO::MATIO)


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
install(DIRECTORY ../include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# This makes the project importable from the install directory
# Put config file in per-project dir (name MUST match), can also
# just go into 'cmake'.
# install(EXPORT MyLibraryConfig DESTINATION share/MyLibrary/cmake)

# This makes the project importable from the build directory
# export(TARGETS OpenMEEGMaths FILE OpenMEEGMathsConfig.cmake)
