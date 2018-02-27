if (NOT HAVE_ISNORMAL_IN_NAMESPACE_STD)
    include(CheckSymbolExists)
    CHECK_SYMBOL_EXISTS(isnormal math.h HAVE_ISNORMAL_IN_MATH_H)
endif()

message(DEBUG "current source dir : ${CMAKE_CURRENT_SOURCE_DIR}")
add_library(OpenMEEG SHARED
    OpenMEEG/src/assembleFerguson.cpp
    OpenMEEG/src/assembleHeadMat.cpp
    OpenMEEG/src/assembleSourceMat.cpp
    OpenMEEG/src/assembleSensors.cpp
    OpenMEEG/src/domain.cpp
    OpenMEEG/src/mesh.cpp
    OpenMEEG/src/interface.cpp
    OpenMEEG/src/danielsson.cpp
    OpenMEEG/src/geometry.cpp
    OpenMEEG/src/operators.cpp
    OpenMEEG/src/sensors.cpp
)


target_include_directories(OpenMEEG
      PUBLIC
          $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/OpenMEEG>
          $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/OpenMEEG/include>
          $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}> # XXX: this is to include the generated file OpenMEEG_Export.h
          $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}>         # XXX: this is to include the generated file OpenMEEGConfigure.h
          ${VTK_INCLUDE_DIRS}
          ${GIFTI_INCLUDE_DIRS}
      PRIVATE
          $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/OpenMEEG/src>
)

target_link_libraries(OpenMEEG
      PUBLIC # XXX : this should become PRIVATE ! and transitive
          OpenMEEG::OpenMEEGMaths
          ${VTK_LIBRARIES}
          ${GIFTI_LIBRARIES}
)


generate_export_header(OpenMEEG
    EXPORT_FILE_NAME OpenMEEG_Export.h
    STATIC_DEFINE OpenMEEG_BUILT_AS_STATIC)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/OpenMEEG/include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
