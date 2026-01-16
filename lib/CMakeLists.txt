# VoxelEngine External Dependencies
# This file includes all FetchContent scripts for project dependencies

message(STATUS "Fetching external dependencies...")

# Core graphics libraries
include(${CMAKE_CURRENT_LIST_DIR}/opengl.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/glfw3.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/glew.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/glm.cmake)

# Audio libraries
include(${CMAKE_CURRENT_LIST_DIR}/openal-soft.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/libvorbis.cmake)

# Compression and encoding
include(${CMAKE_CURRENT_LIST_DIR}/zlib.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/libpng.cmake)

# Scripting
include(${CMAKE_CURRENT_LIST_DIR}/luajit.cmake)

# Networking
include(${CMAKE_CURRENT_LIST_DIR}/curl.cmake)

# Entity Component System
# EnTT is header-only and required on all platforms
include(${CMAKE_CURRENT_LIST_DIR}/entt.cmake)

# Testing (optional)
if(VOXELENGINE_BUILD_TESTS)
    include(${CMAKE_CURRENT_LIST_DIR}/gtest.cmake)
endif()

message(STATUS "All dependencies fetched successfully")