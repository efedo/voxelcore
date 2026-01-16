include(FetchContent)

FetchContent_Declare(
    luajit
    GIT_REPOSITORY https://github.com/LuaJIT/LuaJIT.git
    GIT_TAG        v2.1
    GIT_SHALLOW    TRUE
)

FetchContent_GetProperties(luajit)
if(NOT luajit_POPULATED)
    FetchContent_Populate(luajit)
    
    # LuaJIT requires custom build
    include(ExternalProject)
    
    # Determine build command and library extension based on compiler
    if(MSVC)
        # Use msvcbuild.bat for MSVC
        set(LUAJIT_BUILD_COMMAND cd ${luajit_SOURCE_DIR}/src && msvcbuild.bat)
        set(LUAJIT_LIB_NAME "lua51.lib")
        set(LUAJIT_LIB_PATH "${luajit_SOURCE_DIR}/src/${LUAJIT_LIB_NAME}")
    else()
        # Use make for Unix-like systems
        set(LUAJIT_BUILD_COMMAND make -C ${luajit_SOURCE_DIR}/src)
        set(LUAJIT_LIB_NAME "libluajit.a")
        set(LUAJIT_LIB_PATH "${luajit_SOURCE_DIR}/src/${LUAJIT_LIB_NAME}")
    endif()
    
    ExternalProject_Add(
        luajit_build
        SOURCE_DIR ${luajit_SOURCE_DIR}
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${LUAJIT_BUILD_COMMAND}
        INSTALL_COMMAND ""
        BUILD_IN_SOURCE 1
    )
    
    # Create imported library
    add_library(luajit STATIC IMPORTED GLOBAL)
    add_dependencies(luajit luajit_build)
    
    set_target_properties(luajit PROPERTIES
        IMPORTED_LOCATION "${LUAJIT_LIB_PATH}"
        INTERFACE_INCLUDE_DIRECTORIES "${luajit_SOURCE_DIR}/src"
    )
    
    # Create alias
    if(NOT TARGET luajit::luajit)
        add_library(luajit::luajit ALIAS luajit)
    endif()
endif()