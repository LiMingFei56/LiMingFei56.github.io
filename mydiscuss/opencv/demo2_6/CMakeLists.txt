cmake_minimum_required (VERSION 2.6)
cmake_policy(SET CMP0012 NEW)
PROJECT(demo2_6)

FIND_PACKAGE(OpenCV 3.0.0 REQUIRED)
MESSAGE("OpenCV version : ${OpenCV_VERSION}")

include_directories(${OpenCV_INCLUDE_DIRS})
link_directories(${OpenCV_LIB_DIR})
ADD_EXECUTABLE(demo2_6 main.cpp)
TARGET_LINK_LIBRARIES(demo2_6 ${OpenCV_LIBS})

