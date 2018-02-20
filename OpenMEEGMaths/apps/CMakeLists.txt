add_executable(om_assemble assemble.cpp)
target_link_libraries(om_assemble OpenMEEG::OpenMEEGMaths)

install(TARGETS om_assemble
        ARCHIVE DESTINATION ${CMAKE_INSTALL_BINDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
