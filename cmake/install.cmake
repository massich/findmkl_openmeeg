# Packaging stuff
# include(Packaging)
message(DEBUG ${CMAKE_INSTALL_LIBDIR})
include(GNUInstallDirs)
message(DEBUG ${CMAKE_INSTALL_LIBDIR})
# get_cmake_property(_variableNames VARIABLES)
# message(STATUS "---- sik -----")
# foreach (_variableName ${_variableNames})
#     message(STATUS "${_variableName}=${${_variableName}}")
# endforeach()
# message(STATUS "---- sik -----")

# set(OpenMEEG_INCLUDE_DIRECTORIES
#     ${CMAKE_CURRENT_BINARY_DIR}
#     ${CMAKE_CURRENT_SOURCE_DIR}
#     # ${CMAKE_CURRENT_SOURCE_DIR}/src
#     ${CMAKE_CURRENT_SOURCE_DIR}/OpenMEEGMaths/include
#     ${CMAKE_CURRENT_SOURCE_DIR}/OpenMEEG/include
#     ${CMAKE_CURRENT_BINARY_DIR}/OpenMEEG/src
#     ${CMAKE_CURRENT_BINARY_DIR}/OpenMEEGMaths/src
#     # ${OpenMEEG_OTHER_INCLUDE_DIRS}
#     # ${matio_INCLUDE_DIRS}
# )
