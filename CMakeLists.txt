cmake_minimum_required (VERSION 3.2)
project (OpenMEEG_lib VERSION 2.4.0)

set(BUILD_TESTING True)
enable_testing()

set(OpenMEEG_HEADER_INSTALLDIR include) # XXX I don't know why this should be here

# Modify where to find the modules
list(APPEND CMAKE_MODULE_PATH
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/FortranCInterface
    ${CMAKE_MODULE_PATH}
)

#---------------------------------------------------------------
# Test and setup the C++ compiler features
#---------------------------------------------------------------

include(CheckCXXFeatures)
CHECK_CXX_STANDARD_LIBRARY()

if (NOT HAVE_ISNORMAL_IN_NAMESPACE_STD)
    include(CheckSymbolExists)
    check_symbol_exists(isnormal math.h HAVE_ISNORMAL_IN_MATH_H)
endif()

if(MSVC)
    # to allow the use of and, or instead of && ||
    add_compile_options("/Za")
endif()

################
# OpenMEEG stuff
################
include(GenerateExportHeader)
include(cmake/options.cmake)
include(cmake/thirdParties.cmake)
include(cmake/install.cmake)


configure_file(${CMAKE_CURRENT_SOURCE_DIR}/OpenMEEGConfigure.h.in
               ${CMAKE_CURRENT_BINARY_DIR}/OpenMEEGConfigure.h)

# include_directories(${OpenMEEG_INCLUDE_DIRECTORIES})
add_subdirectory(OpenMEEGMaths)
add_subdirectory(OpenMEEG)
add_subdirectory(apps)

# Use a proper config file
# install(EXPORT OpenMEEGConfig
#     FILE OpenMEEGConfig.cmake
#     NAMESPACE OpenMEEG::
#     DESTINATION lib/cmake/OpenMEEGConfig
# )
