cmake_minimum_required (VERSION 3.2)
project (OpenMEEG_lib)

set(BUILD_TESTING True)
enable_testing()

#version number
set (OpenMEEG_libs_VERSION_MAJOR 1)
set (OpenMEEG_libs_VERSION_MINOR 0)


set(OpenMEEG_HEADER_INSTALLDIR include) # XXX I don't know why this should be here

# Modify where to find the modules
set(CMAKE_MODULE_PATH
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/FortranCInterface
    ${CMAKE_MODULE_PATH}
)


#########
# OpenMEEG stuff
#####
include(GenerateExportHeader)

set(OpenMEEG_INCLUDE_DIRECTORIES
    ${CMAKE_CURRENT_BINARY_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}
    # ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}/OpenMEEGMaths/include
    ${CMAKE_CURRENT_SOURCE_DIR}/OpenMEEG/include
    ${CMAKE_CURRENT_BINARY_DIR}/OpenMEEG/src
    ${CMAKE_CURRENT_BINARY_DIR}/OpenMEEGMaths/src
    # ${OpenMEEG_OTHER_INCLUDE_DIRS}
    # ${matio_INCLUDE_DIRS}
)

#########
# FindMKL stuff
#####
set(BLA_DEFINITIONS)

if ("$ENV{MKLROOT}" STREQUAL "")
    message(FATAL_ERROR "MKLROOT is not set. Please source the Intel MKL mklvars.sh file.")
endif()

# user defined options for MKL
option(MKL_USE_parallel "Use MKL parallel" True)
option(MKL_USE_sdl "Single Dynamic Library or static/dynamic" False)
set(MKL_USE_interface "lp64" CACHE STRING "for Intel(R)64 compatible arch: ilp64/lp64 or for ia32 arch: cdecl/stdcall")

if (BLA_VENDOR MATCHES "_seq")
    set(MKL_USE_parallel OFF)
else()
    set(MKL_USE_parallel ON)
endif()

find_package(MKL REQUIRED)

if (MKL_FOUND)
    include_directories(${MKL_INCLUDE_DIR})
    set(BLA_INCLUDE_DIR ${MKL_INCLUDE_DIR})
    set(LAPACK_LIBRARIES ${MKL_LIBRARIES})
    set(BLA_DEFINITIONS USE_MKL HAVE_BLAS HAVE_LAPACK)
    # set(USE_MKL True)
    # set(HAVE_BLAS True)
    # set(HAVE_LAPACK True)
endif()

find_package(matio REQUIRED)

# message(STATUS "BLAS Libraries: ${BLAS_LIBRARIES}")

option(ENABLE_COVERAGE "Enable coverage" OFF)

if (ENABLE_COVERAGE)
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        set(COVERAGE_FLAGS "-fprofile-arcs -ftest-coverage")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${COVERAGE_FLAGS} -lgcov")
    elseif("${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang")
        set(COVERAGE_FLAGS "-coverage")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${COVERAGE_FLAGS}")
    else()
        message(SEND_ERROR "Coverage is only available with gcc or clang.")
    endif()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${COVERAGE_FLAGS}")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${COVERAGE_FLAGS}")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${COVERAGE_FLAGS}")
endif()

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/OpenMEEGConfigure.h.in
               ${CMAKE_CURRENT_BINARY_DIR}/OpenMEEGConfigure.h)

include_directories(${OpenMEEG_INCLUDE_DIRECTORIES})
add_subdirectory(OpenMEEGMaths)
