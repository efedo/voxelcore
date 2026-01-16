project(VoxelEngineSrc)

file(GLOB_RECURSE headers ${CMAKE_CURRENT_SOURCE_DIR}/*.hpp)
file(GLOB_RECURSE sources ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)
list(REMOVE_ITEM sources ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)

add_library(VoxelEngineSrc STATIC ${sources} ${headers})

find_package(OpenGL REQUIRED)

target_include_directories(VoxelEngineSrc PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(
    VoxelEngineSrc
    PRIVATE glfw
            OpenGL::GL
            GLEW::GLEW
            ZLIB::ZLIB
            PNG::PNG
            CURL::libcurl
            OpenAL::OpenAL
            Vorbis::vorbis
            Vorbis::vorbisfile
            luajit::luajit
            EnTT::EnTT
    PUBLIC glm::glm # Need public for src/delegates.hpp, which including to
                    # main.cpp
)

target_compile_options(
    VoxelEngineSrc
    PUBLIC $<$<CXX_COMPILER_ID:MSVC>:
           /utf-8
           /MP
           /D_DISABLE_CONSTEXPR_MUTEX_CONSTRUCTOR
           /W4
           /wd4244 # conversion from 'a' to 'T', possible loss of data
           /wd4267 # conversion from 'size_t' to 'int', possible loss of data
           /wd4245 # conversion from 'int' to 'const size_t', signed/unsigned
                   # mismatch
           /wd4100 # unreferenced formal parameter
           /wd4457 # declaration of 'var' hides function parameter 
           /wd4458 # declaration of 'var' hides class member
           /wd4459 # declaration of 'var' hides global declaration 
           /wd4101 # 'var': unreferenced local variable
           /wd4388 # 'token' : signed/unsigned mismatch
           /wd4018 # '>': signed/unsigned mismatch
           >
           $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:
           -Wall
           -Wextra
           # additional warnings
           -Wformat-nonliteral
           #-Wsign-conversion
           -Wcast-align
           -Wpointer-arith
           -Wundef
           -Wwrite-strings
           -Wno-unused-parameter
           -Wno-sign-compare
           -Wno-unknown-pragmas
           >
           $<$<CXX_COMPILER_ID:GNU>:
           -Wduplicated-branches
           -Wduplicated-cond
           >)

target_link_options(
    VoxelEngineSrc
    PUBLIC
    $<$<CXX_COMPILER_ID:GNU>:
    -no-pie
    >
    # Need for static compilation on Windows with clang TODO: Make single build
    # on Windows to avoid dependence on combinations of platforms and compilers
    # and make it independent
    $<$<PLATFORM_ID:Windows>:$<$<CXX_COMPILER_ID:Clang>:-static>>)

FetchContent_GetProperties(libpng SOURCE_DIR PNG_SOURCE_DIR BINARY_DIR PNG_BINARY_DIR)
target_include_directories(png_static PUBLIC
       ${PNG_SOURCE_DIR}
       ${PNG_BINARY_DIR}
   )
