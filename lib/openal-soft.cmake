include(FetchContent)

FetchContent_Declare(
    openal-soft
    GIT_REPOSITORY https://github.com/kcat/openal-soft.git
    GIT_TAG        1.23.1
    GIT_SHALLOW    TRUE
)

# OpenAL-Soft options
set(ALSOFT_UTILS OFF CACHE BOOL "" FORCE)
set(ALSOFT_NO_CONFIG_UTIL ON CACHE BOOL "" FORCE)
set(ALSOFT_EXAMPLES OFF CACHE BOOL "" FORCE)
set(ALSOFT_TESTS OFF CACHE BOOL "" FORCE)
set(ALSOFT_INSTALL OFF CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(openal-soft)

# Create alias for consistency
if(NOT TARGET OpenAL::OpenAL)
    add_library(OpenAL::OpenAL ALIAS OpenAL)
endif()

# Set variables expected by FindOpenAL.cmake
FetchContent_GetProperties(openal-soft SOURCE_DIR OPENAL_SOURCE_DIR)
set(OPENAL_FOUND TRUE CACHE BOOL "OpenAL found")
set(OPENAL_INCLUDE_DIR "${OPENAL_SOURCE_DIR}/include" CACHE PATH "OpenAL include directory")
set(OPENAL_LIBRARY OpenAL::OpenAL CACHE STRING "OpenAL library")

mark_as_advanced(OPENAL_FOUND OPENAL_INCLUDE_DIR OPENAL_LIBRARY)