# Locate cppcheck
#
# This module defines
#  CPPCHECK_FOUND, if false, do not try to link to cppcheck --- if (CPPCHECK_FOUND)
#  CPPCHECK_BIN, where to find cppcheck
#
# Exported argumets include
#   CPPCHECK_ARG
#
# find the cppcheck binary
find_program(CPPCHECK_BIN NAMES cppcheck)

# Arguments can be:
# -j use multiple threads (and thread count)
# --quiet only show errors / warnings etc
# --error-exitcode The code to exit with if an error shows up
# --enabled  Comma seperated list of the check types. Can include warning,performance,style
# Note nightly build on earth changes error-exitcode to 0

set (CPPCHECK_ARG "--quiet -j 2 --error-exitcode=1" CACHE STRING "cppcheck arguments.")
message(STATUS "CPPCHECK_ARG: ${CPPCHECK_ARG}")

# handle the QUIETLY and REQUIRED arguments and set YAMLCPP_FOUND to TRUE if all listed variables are TRUE
include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(
    CPPCHECK 
    DEFAULT_MSG 
    CPPCHECK_BIN
    CPPCHECK_ARG)

mark_as_advanced(
    CPPCHECK_BIN
    CPPCHECK_ARG)