# Find the matio headers and library.
#
#  matio_INCLUDE_DIRS - where to find matio.h, etc.
#  matio_LIBRARIES    - List of libraries.
#  matio_FOUND        - True if matio found.

#   We provide a module in case matio has not been found in config mode.

if (NOT matio_LIBRARIES)

    find_package(HDF5 REQUIRED)

    # Make a modern cmake interface to HDF5
    add_library(HDF5::HDF5 UNKNOWN IMPORTED)
    set_target_properties(HDF5::HDF5 PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${HDF5_INCLUDE_DIRS}"
        IMPORTED_LOCATION "${HDF5_LIBRARIES}")

    # Look for the header file.

    set(conda_matio /home/travis/miniconda/pkgs/libmatio-1.5.11-0/)
    find_path(matio_INCLUDE_DIR
	    HINTS
        	$ENV{matio_dir}include
          ${conda_matio}include
	    NAMES
	    	matio.h
	    )

    message(STATUS "matio.h ${matio_INCLUDE_DIR}")
    mark_as_advanced(matio_INCLUDE_DIR)

    # Look for the library.

    # XXXX This needs to go out !
    set(matio_LIB_SEARCH_PATHS
        C:/conda/Library/
        C:/conda/Library/lib
        C:/conda/Library/bin
        $ENV{matio_dir}
        $ENV{matio_dir}lib
        $ENV{matio_dir}bin
        ${conda_matio}
        ${conda_matio}lib
        ${conda_matio}bin
        )

    find_library(matio_LIBRARY
	    HINTS
	    	${matio_LIB_SEARCH_PATHS}
	    NAMES
        matio libmatio
	    )
    message(STATUS "matio_library ${matio_LIBRARY}")
    mark_as_advanced(matio_LIBRARY)

    # handle the QUIETLY and REQUIRED arguments and set matio_FOUND to TRUE if
    # all listed variables are TRUE
    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(matio DEFAULT_MSG matio_LIBRARY matio_INCLUDE_DIR)

    if (matio_FOUND AND NOT TARGET MATIO::MATIO)
        add_library(MATIO::MATIO UNKNOWN IMPORTED)
        set_target_properties(MATIO::MATIO PROPERTIES
            IMPORTED_LINK_LIBRARIES HDF5::HDF5
            INTERFACE_INCLUDE_DIRECTORIES ${matio_INCLUDE_DIR}
            IMPORTED_LOCATION ${matio_LIBRARY}
        )
    endif()
endif()
