include(FetchContent)

FetchContent_Declare(
    zlib
    GIT_REPOSITORY https://github.com/madler/zlib.git
    GIT_TAG        v1.3.1
    GIT_SHALLOW    TRUE
)

# Configure zlib BEFORE making it available
set(SKIP_INSTALL_ALL ON CACHE BOOL "Skip zlib install" FORCE)
set(SKIP_INSTALL_LIBRARIES ON CACHE BOOL "Skip zlib library install" FORCE)
set(SKIP_INSTALL_HEADERS ON CACHE BOOL "Skip zlib header install" FORCE)
set(SKIP_INSTALL_FILES ON CACHE BOOL "Skip zlib file install" FORCE)

# Make zlib available AFTER setting options
FetchContent_MakeAvailable(zlib)

# Configure the target properties
if(TARGET zlibstatic)
    set_target_properties(zlibstatic PROPERTIES 
        EXCLUDE_FROM_ALL OFF
        POSITION_INDEPENDENT_CODE ON
    )
endif()

# Set variables that FindZLIB.cmake expects
set(ZLIB_FOUND TRUE CACHE BOOL "ZLIB found" FORCE)
set(ZLIB_LIBRARY zlibstatic CACHE STRING "ZLIB library" FORCE)
set(ZLIB_LIBRARIES zlibstatic CACHE STRING "ZLIB libraries" FORCE)
set(ZLIB_INCLUDE_DIR "${zlib_SOURCE_DIR};${zlib_BINARY_DIR}" CACHE STRING "ZLIB include directories" FORCE)
set(ZLIB_INCLUDE_DIRS "${zlib_SOURCE_DIR};${zlib_BINARY_DIR}" CACHE STRING "ZLIB include directories" FORCE)

# Create the alias for consistency with find_package
if(NOT TARGET ZLIB::ZLIB)
    add_library(ZLIB::ZLIB ALIAS zlibstatic)
endif()