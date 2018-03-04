###############
# FindMKL stuff
###############
set(BLA_DEFINITIONS)


if (BLA_VENDOR MATCHES Intel)
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
    endif()
else()
    find_package(BLAS REQUIRED)
    if (BLA_VENDOR MATCHES ATLAS)
        find_library(CBLAS_LIB NAMES cblas)
        set(BLAS_LIBRARIES "${BLAS_LIBRARIES};${CBLAS_LIB}")
        set(BLA_DEFINITIONS USE_ATLAS HAVE_BLAS HAVE_LAPACK)
    elseif(BLA_VENDOR MATCHES Apple)
        set(BLA_DEFINITIONS USE_VECLIB HAVE_BLAS HAVE_LAPACK)
    endif()
    set(LAPACK_LIBRARIES ${BLAS_LIBRARIES})
endif()

find_package(Threads)
find_package(matio REQUIRED)
