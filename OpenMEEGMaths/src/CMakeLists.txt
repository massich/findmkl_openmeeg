# =====================
# = OpenMEEGMaths Lib =
# =====================

# function(create_library libname)
#     add_library(${libname} SHARED ${ARGN})
#     target_link_libraries(${libname} ${LAPACK_LIBRARIES} ${matio_LIBRARIES})
#     if (LAPACK_DEFINITIONS) # mainly for MKL
#         target_compile_definitions(${libname} PUBLIC ${LAPACK_DEFINITIONS})
#     endif()

#     set_target_properties(${libname} PROPERTIES
#                           VERSION 1.1.0
#                           SOVERSION 1
#                           #INTERFACE_LINK_LIBRARIES "${NeededLibraries}"
#                           CLEAN_DIRECT_OUTPUT 1)

#     # message('sik2')
#     # message(${CMAKE_CURRENT_SOURCE_DIR})
#     # message(${CMAKE_CURRENT_BINARY_DIR})

#     # message(${libname}
#     #     EXPORT_FILE_NAME ${libname}_Export.h
#     #     STATIC_DEFINE ${libname}_BUILT_AS_STATIC)
#     # message('sik2')

#     # generate_export_header(${libname}
#     #     EXPORT_FILE_NAME ${libname}_Export.h
#     #     STATIC_DEFINE ${libname}_BUILT_AS_STATIC)

#     install(TARGETS ${libname}
#             EXPORT  OpenMEEGTargets
#             RUNTIME DESTINATION ${INSTALL_BIN_DIR}
#             ARCHIVE DESTINATION ${INSTALL_LIB_DIR}
#             LIBRARY DESTINATION ${INSTALL_LIB_DIR})

#     # install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${libname}_Export.h
#     #         DESTINATION ${OpenMEEG_HEADER_INSTALLDIR} COMPONENT Development)
# endfunction()

set(OpenMEEGMaths_SOURCES
    utils.cpp vector.cpp matrix.cpp symmatrix.cpp sparse_matrix.cpp fast_sparse_matrix.cpp
    MathsIO.C AsciiIO.C BrainVisaTextureIO.C TrivialBinIO.C)
    # MathsIO.C MatlabIO.C AsciiIO.C BrainVisaTextureIO.C TrivialBinIO.C)

# set(CMAKE_CXX_VISIBILITY_PRESET hidden)
# set(CMAKE_VISIBILITY_INLINES_HIDDEN 1)
add_library(OpenMEEGMaths SHARED ${OpenMEEGMaths_SOURCES})
target_link_libraries(OpenMEEGMaths ${LAPACK_LIBRARIES} ${matio_LIBRARIES})

generate_export_header(OpenMEEGMaths
    EXPORT_FILE_NAME OpenMEEGMaths_Export.h
    STATIC_DEFINE OpenMEEGMaths_BUILT_AS_STATIC)

# create_library(OpenMEEGMaths ${OpenMEEGMaths_SOURCES})
