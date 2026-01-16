include(FetchContent)

FetchContent_Declare(
    libogg
    GIT_REPOSITORY https://github.com/xiph/ogg.git
    GIT_TAG        v1.3.5
    GIT_SHALLOW    TRUE
)

# Fetch and build Ogg first (required by Vorbis)
FetchContent_MakeAvailable(libogg)

# Set variables that libvorbis's FindOgg.cmake will look for
# This bridges FetchContent with find_package
set(OGG_INCLUDE_DIR "${libogg_SOURCE_DIR}/include" CACHE PATH "Ogg include directory")
set(OGG_LIBRARY ogg CACHE STRING "Ogg library target")
set(Ogg_FOUND TRUE CACHE BOOL "Ogg found via FetchContent")

FetchContent_Declare(
    libvorbis
    GIT_REPOSITORY https://github.com/xiph/vorbis.git
    GIT_TAG        v1.3.7
    GIT_SHALLOW    TRUE
)

# Now fetch Vorbis - it should find our pre-built Ogg
FetchContent_MakeAvailable(libvorbis)

# Create aliases for consistency
if(NOT TARGET Vorbis::vorbis)
    add_library(Vorbis::vorbis ALIAS vorbis)
endif()

if(NOT TARGET Vorbis::vorbisfile)
    add_library(Vorbis::vorbisfile ALIAS vorbisfile)
endif()