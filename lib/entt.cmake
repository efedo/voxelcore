include(FetchContent)

FetchContent_Declare(
    entt
    GIT_REPOSITORY https://github.com/skypjack/entt.git
    GIT_TAG        v3.13.2
    GIT_SHALLOW    TRUE
)

# EnTT options
set(ENTT_BUILD_TESTING OFF CACHE BOOL "" FORCE)
set(ENTT_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(ENTT_BUILD_EXAMPLE OFF CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(entt)

# Set variables expected by find_package(EnTT)
FetchContent_GetProperties(entt SOURCE_DIR ENTT_SOURCE_DIR)
set(EnTT_FOUND TRUE CACHE BOOL "EnTT found")
set(ENTT_INCLUDE_DIRS "${ENTT_SOURCE_DIR}/src" CACHE PATH "EnTT include directory")

mark_as_advanced(EnTT_FOUND ENTT_INCLUDE_DIRS)

# EnTT is header-only, target EnTT::EnTT is provided by the library