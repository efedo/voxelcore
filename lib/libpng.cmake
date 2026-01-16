include(FetchContent)

FetchContent_Declare(
    libpng
    GIT_REPOSITORY https://github.com/glennrp/libpng.git
    GIT_TAG        v1.6.43
    GIT_SHALLOW    TRUE
)

# libpng options
set(PNG_TESTS OFF CACHE BOOL "" FORCE)
set(PNG_BUILD_ZLIB OFF CACHE BOOL "" FORCE)
set(PNG_SHARED OFF CACHE BOOL "" FORCE)
set(PNG_STATIC ON CACHE BOOL "" FORCE)

# Ensure zlib is available first
find_package(ZLIB QUIET)
if(NOT ZLIB_FOUND)
    include(${CMAKE_CURRENT_LIST_DIR}/zlib.cmake)
endif()

FetchContent_MakeAvailable(libpng)

# Create alias for consistency
if(NOT TARGET PNG::PNG)
    add_library(PNG::PNG ALIAS png_static)
endif()

# Set variables expected by FindPNG.cmake
FetchContent_GetProperties(libpng SOURCE_DIR PNG_SOURCE_DIR)
set(PNG_FOUND TRUE CACHE BOOL "PNG found")
set(PNG_INCLUDE_DIRS "${PNG_SOURCE_DIR};${libpng_BINARY_DIR}" CACHE PATH "PNG include directories")
set(PNG_LIBRARIES PNG::PNG CACHE STRING "PNG libraries")
set(PNG_LIBRARY PNG::PNG CACHE STRING "PNG library")

mark_as_advanced(PNG_FOUND PNG_INCLUDE_DIRS PNG_LIBRARIES PNG_LIBRARY)