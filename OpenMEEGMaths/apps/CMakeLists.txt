add_executable(om_assemble assemble.cpp geometry.cpp sensors.cpp)
target_link_libraries(om_assemble OpenMEEG::OpenMEEGMaths)
target_include_directories(om_assemble PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

install(TARGETS om_assemble
        ARCHIVE DESTINATION ${CMAKE_INSTALL_BINDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
