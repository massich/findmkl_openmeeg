# Find the matio headers and library.
#
#  matio_INCLUDE_DIRS - where to find matio.h, etc.
#  matio_LIBRARIES    - List of libraries.
#  matio_FOUND        - True if matio found.

#   We provide a module in case matio has not been found in config mode.

if (NOT matio_LIBRARIES)

    find_package(HDF5 REQUIRED)

    # Look for the header file.

    find_path(matio_INCLUDE_DIR
	    HINTS
        	$ENV{matio_dir}include
	    NAMES 
	    	matio.h
	    )
    
    message(STATUS "matio.h ${matio_INCLUDE_DIR}")
    mark_as_advanced(matio_INCLUDE_DIR)

    # Look for the library.

    set(matio_LIB_SEARCH_PATHS
        $ENV{matio_dir}
        $ENV{matio_dir}lib
        $ENV{matio_dir}bin
        )

    find_library(matio_LIBRARY 
	    HINTS 
	    	${matio_LIB_SEARCH_PATHS}
	    NAMES matio 
	    )
    message(STATUS "matio_library ${matio_LIBRARY}")

    ##[===[
    message(STATUS "---------   sik  ------------")

    find_library(xx_b HINTS ${matio_LIB_SEARCH_PATHS} NAMES matio )
    message(STATUS "--   sik  -- xx_b: ${xx_b}")

    find_library(xx_c HINTS $ENV{matio_dir} NAMES matio)
    message(STATUS "--   sik  -- xx_c: ${xx_c}")

    find_library(xx_d HINTS $ENV{matio_dir}lib NAMES matio)
    message(STATUS "--   sik  -- xx_d: ${xx_d}")

    find_library(xx_e HINTS $ENV{matio_dir}bin NAMES matio)
    message(STATUS "--   sik  -- xx_e: ${xx_e}")

    message(STATUS "---------   sik  ------------")
    
    #]===]
    

    mark_as_advanced(matio_LIBRARY)

    # handle the QUIETLY and REQUIRED arguments and set matio_FOUND to TRUE if
    # all listed variables are TRUE

    # include(FindPackageHandleStandardArgs)
    # find_package_handle_standard_args(matio DEFAULT_MSG matio_LIBRARY matio_INCLUDE_DIR)

    #if (MATIO_FOUND)
        set(matio_FOUND TRUE)
        set(matio_LIBRARIES ${matio_LIBRARY} ${HDF5_LIBRARIES})
        set(matio_INCLUDE_DIRS ${matio_INCLUDE_DIR} ${HDF5_INCLUDE_DIR})
	#else()
    	#    set(matio_LIBRARIES)
    	#    set(matio_INCLUDE_DIRS)
    	#endif()

    # include(matioVersion)
endif()
