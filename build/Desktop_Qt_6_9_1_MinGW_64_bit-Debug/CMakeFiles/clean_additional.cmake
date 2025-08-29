# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appPracticeQT_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appPracticeQT_autogen.dir\\ParseCache.txt"
  "appPracticeQT_autogen"
  )
endif()
