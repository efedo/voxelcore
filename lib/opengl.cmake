# OpenGL is typically provided by the system
find_package(OpenGL REQUIRED)

if(NOT TARGET OpenGL::GL)
    message(FATAL_ERROR "OpenGL not found")
endif()

message(STATUS "OpenGL found")