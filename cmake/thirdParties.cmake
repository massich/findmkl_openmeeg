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
    set(BLA_INCLUDE_DIR ${MKL_INCLUDE_DIR})
    set(LAPACK_LIBRARIES ${MKL_LIBRARIES})
    set(BLA_DEFINITIONS USE_MKL HAVE_BLAS HAVE_LAPACK)
    # set(USE_MKL True)
    # set(HAVE_BLAS True)
    # set(HAVE_LAPACK True)
endif()

# include_directories(external/include/)
find_package(Threads)
find_package(matio REQUIRED)

# message(STATUS "BLAS Libraries: ${BLAS_LIBRARIES}")
