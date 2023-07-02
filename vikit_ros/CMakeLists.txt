SET(PROJECT_NAME vikit_ros)
PROJECT(${PROJECT_NAME})
cmake_minimum_required(VERSION 3.11.4)
SET(CMAKE_BUILD_TYPE Release) # Release, RelWithDebInfo
SET(CMAKE_VERBOSE_MAKEFILE OFF)

add_compile_options("-Wno-int-in-bool-context")

# Set build flags
SET(CMAKE_CXX_FLAGS "-Wall -D_LINUX -D_REENTRANT -march=native -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unknown-pragmas")
SET(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} -O0 -g")
IF(CMAKE_COMPILER_IS_GNUCC)
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
ELSE()
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
ENDIF()

message("DEBUG: CMAKE_CURRENT_BINARY_DIR: ${CMAKE_CURRENT_BINARY_DIR}")
message("DEBUG: CMAKE_BINARY_DIR: ${CMAKE_BINARY_DIR}")
message("DEBUG: CMAKE_SOURCE_DIR: ${CMAKE_SOURCE_DIR}")

# Add catkin and required ROS packages
FIND_PACKAGE(catkin REQUIRED COMPONENTS roscpp vikit_common visualization_msgs tf cmake_modules)

# Add plain cmake packages 
FIND_PACKAGE(OpenCV REQUIRED)

# Include dirs
INCLUDE_DIRECTORIES(
  include
  ${eigen_INCLUDE_DIR}
  ${OpenCV_INCLUDE_DIRS}
  ${sophus_INCLUDE_DIR}
  ${catkin_INCLUDE_DIRS}
)

# Describe catkin Project
catkin_package(
    DEPENDS OpenCV vikit_common
    CATKIN_DEPENDS roscpp visualization_msgs tf 
    INCLUDE_DIRS include
    LIBRARIES ${PROJECT_NAME}
)

# Set Sourcefiles
LIST(APPEND SOURCEFILES 
  src/output_helper.cpp
)

# Create vikit library
ADD_LIBRARY(${PROJECT_NAME} SHARED ${SOURCEFILES})
add_dependencies(${PROJECT_NAME} sophus eigen)
TARGET_LINK_LIBRARIES(
  ${PROJECT_NAME}
  ${OpenCV_LIBS}
  ${sophus_LIBS}
  ${catkin_LIBRARIES})