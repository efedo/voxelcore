include(FetchContent)

FetchContent_Declare(
    glew
    GIT_REPOSITORY https://github.com/Perlmint/glew-cmake.git
    GIT_TAG        glew-cmake-2.2.0
    GIT_SHALLOW    TRUE
)

# GLEW options
set(glew-cmake_BUILD_SHARED OFF CACHE BOOL "" FORCE)
set(glew-cmake_BUILD_STATIC ON CACHE BOOL "" FORCE)
set(ONLY_LIBS ON CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(glew)

# Create alias for compatibility
if(NOT TARGET GLEW::GLEW)
    add_library(GLEW::GLEW ALIAS libglew_static)
endif()

# Set variables for compatibility (if needed elsewhere)
FetchContent_GetProperties(glew)
set(GLEW_INCLUDE_DIRS "${glew_SOURCE_DIR}/include" CACHE PATH "GLEW include directory")
set(GLEW_LIBRARIES GLEW::GLEW CACHE STRING "GLEW libraries")
set(GLEW_FOUND TRUE CACHE BOOL "GLEW found")

mark_as_advanced(GLEW_INCLUDE_DIRS GLEW_LIBRARIES GLEW_FOUND)