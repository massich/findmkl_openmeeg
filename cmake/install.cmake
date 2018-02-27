# Install and Packaging stuff

if (APPLE)
    set(CMAKE_MACOSX_RPATH 1)
    set(CMAKE_SKIP_BUILD_RPATH  FALSE)
    set(CMAKE_INSTALL_RPATH "@executable_path/../lib/")
    set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
elseif(UNIX)  # means if LINUX
    # to fix the installed rpath so it looks in ../lib
    # https://www.semipol.de/2012/02/16/relative-rpath-settings-with-cmake.html
    set(CMAKE_INSTALL_RPATH "$ORIGIN/../lib")
endif()

include(Packaging)
include(GNUInstallDirs)
