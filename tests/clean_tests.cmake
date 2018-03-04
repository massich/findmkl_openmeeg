FILE(GLOB OLD_FILES "${CMAKE_CURRENT_BINARY_DIR}/../tests/Head*")
SET(TMP_FILE "Head-tmp.txt")
LIST(APPEND OLD_FILES ${OLD_FILES} ${TMP_FILE})
LIST(REMOVE_DUPLICATES OLD_FILES)
EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E remove -f ${OLD_FILES})
