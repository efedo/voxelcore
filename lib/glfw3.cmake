include(FetchContent)

FetchContent_Declare(
    glfw
    GIT_REPOSITORY https://github.com/glfw/glfw.git
    GIT_TAG        3.4
    GIT_SHALLOW    TRUE
)

# GLFW options
set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set(GLFW_INSTALL OFF CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(glfw)

# Set variables expected by find_package(glfw3)
FetchContent_GetProperties(glfw SOURCE_DIR GLFW_SOURCE_DIR)
set(glfw3_FOUND TRUE CACHE BOOL "glfw3 found")
set(GLFW_INCLUDE_DIR "${GLFW_SOURCE_DIR}/include" CACHE PATH "GLFW include directory")
set(GLFW_LIBRARY glfw CACHE STRING "GLFW library")

mark_as_advanced(glfw3_FOUND GLFW_INCLUDE_DIR GLFW_LIBRARY)