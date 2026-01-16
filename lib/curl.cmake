include(FetchContent)

FetchContent_Declare(
    curl
    GIT_REPOSITORY https://github.com/curl/curl.git
    GIT_TAG        curl-8_10_1
    GIT_SHALLOW    TRUE
)

# CURL options
set(BUILD_CURL_EXE OFF CACHE BOOL "" FORCE)
set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)
set(CURL_ENABLE_SSL ON CACHE BOOL "" FORCE)
set(BUILD_TESTING OFF CACHE BOOL "" FORCE)
set(CURL_CA_BUNDLE "auto" CACHE STRING "" FORCE)


set(CURL_ENABLE_EXPORT_TARGET OFF CACHE BOOL "Disable curl export" FORCE)
set(SKIP_INSTALL_ALL ON CACHE BOOL "Skip curl install" FORCE)

FetchContent_MakeAvailable(curl)

# Create alias for consistency
if(NOT TARGET CURL::libcurl)
    add_library(CURL::libcurl ALIAS libcurl)
endif()

# Set variables expected by FindCURL.cmake
FetchContent_GetProperties(curl SOURCE_DIR CURL_SOURCE_DIR)
set(CURL_FOUND TRUE CACHE BOOL "CURL found")
set(CURL_INCLUDE_DIRS "${CURL_SOURCE_DIR}/include;${curl_BINARY_DIR}/include" CACHE PATH "CURL include directories")
set(CURL_LIBRARIES CURL::libcurl CACHE STRING "CURL libraries")

mark_as_advanced(CURL_FOUND CURL_INCLUDE_DIRS CURL_LIBRARIES)