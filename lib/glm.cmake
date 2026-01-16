include(FetchContent)

FetchContent_Declare(
    glm
    GIT_REPOSITORY https://github.com/g-truc/glm.git
    GIT_TAG        1.0.1
    GIT_SHALLOW    TRUE
)

# GLM options
set(GLM_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLM_BUILD_INSTALL OFF CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(glm)

# Set variables expected by find_package(glm)
FetchContent_GetProperties(glm SOURCE_DIR GLM_SOURCE_DIR)
set(glm_FOUND TRUE CACHE BOOL "glm found")
set(GLM_INCLUDE_DIRS "${GLM_SOURCE_DIR}" CACHE PATH "GLM include directory")

mark_as_advanced(glm_FOUND GLM_INCLUDE_DIRS)

# GLM is header-only, target glm::glm is already provided by the library