cmake_minimum_required(VERSION 3.5)

option(VOXELENGINE_BUILD_APPDIR "Pack linux build" OFF)
option(VOXELENGINE_BUILD_TESTS "Build tests" OFF)
set(VOXELENGINE_PACKAGE_SOURCE "FetchContent" CACHE STRING 
    "Dependency source: FetchContent, vcpkg, or system")
set_property(CACHE VOXELENGINE_PACKAGE_SOURCE PROPERTY STRINGS 
    "FetchContent" "vcpkg" "system")

# Validate the option
if(NOT VOXELENGINE_PACKAGE_SOURCE MATCHES "^(FetchContent|vcpkg|system)$")
    message(FATAL_ERROR 
        "Invalid VOXELENGINE_PACKAGE_SOURCE: '${VOXELENGINE_PACKAGE_SOURCE}'. "
        "Must be 'FetchContent', 'vcpkg', or 'system'")
endif()

# Disable vcpkg manifest mode unless explicitly using vcpkg
if(NOT VOXELENGINE_PACKAGE_SOURCE STREQUAL "vcpkg")
    set(VCPKG_MANIFEST_MODE OFF CACHE BOOL "Disable vcpkg manifest" FORCE)
endif()

project(VoxelEngine)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_compile_definitions(VC_BUILD_NAME="${VC_BUILD_NAME}")

# Platform-specific configuration (AFTER project())
if(VOXELENGINE_PACKAGE_SOURCE STREQUAL "vcpkg")
    if(NOT DEFINED ENV{VCPKG_ROOT})
        message(FATAL_ERROR "VCPKG_ROOT environment variable is not set.")
    endif()
    if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
        if(VCPKG_TARGET_TRIPLET MATCHES "static")
            set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
        endif()
    endif()
endif()

# FetchContent setup
if(VOXELENGINE_PACKAGE_SOURCE STREQUAL "FetchContent")
    include(FetchContent)
    add_subdirectory(lib)
    
    # Get LuaJIT source directory (must be after lib/ is processed)
    FetchContent_GetProperties(luajit SOURCE_DIR LUAJIT_SOURCE_DIR)
endif()

add_subdirectory(src)
add_executable(VoxelEngine src/main.cpp)

if(VOXELENGINE_BUILD_APPDIR)
    include(${CMAKE_CURRENT_SOURCE_DIR}/dev/cmake/BuildAppdir.cmake)
endif()

target_link_libraries(VoxelEngine PRIVATE VoxelEngineSrc
                                          $<$<PLATFORM_ID:Windows>:winmm>)

target_link_options(VoxelEngine PRIVATE $<$<CXX_COMPILER_ID:GNU>:-no-pie>)

# Deploy res to build dir
add_custom_command(
    TARGET VoxelEngine
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory_if_different
            ${CMAKE_CURRENT_SOURCE_DIR}/res $<TARGET_FILE_DIR:VoxelEngine>/res)

# Copy runtime DLLs to executable directory (Windows only)
if(WIN32 AND VOXELENGINE_PACKAGE_SOURCE STREQUAL "FetchContent")
    add_custom_command(
        TARGET VoxelEngine
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E echo "Copying runtime DLLs..."
        
        # Copy OpenAL32.dll
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
                $<TARGET_FILE:OpenAL::OpenAL>
                $<TARGET_FILE_DIR:VoxelEngine>
        
        # Copy LuaJIT DLL
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
                "${LUAJIT_SOURCE_DIR}/src/lua51.dll"
                $<TARGET_FILE_DIR:VoxelEngine>

        # Example: if you switch to shared libcurl
        #COMMAND ${CMAKE_COMMAND} -E copy_if_different
        #        $<TARGET_FILE:CURL::libcurl>
        #        $<TARGET_FILE_DIR:VoxelEngine>
        
        COMMENT "Deploying runtime dependencies to $<TARGET_FILE_DIR:VoxelEngine>"
    )
endif()

if(VOXELENGINE_BUILD_TESTS)
    enable_testing()
    add_subdirectory(test)
endif()

add_subdirectory(vctest)
