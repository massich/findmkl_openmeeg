add_executable(om_xxx vector.cpp)
target_link_libraries(om_xxx OpenMEEG::OpenMEEGMaths)
target_include_directories(om_xxx PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

install(TARGETS om_xxx
        ARCHIVE DESTINATION ${CMAKE_INSTALL_BINDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
