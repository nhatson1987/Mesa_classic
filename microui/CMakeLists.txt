cmake_minimum_required(VERSION 3.11)
project(microui)
find_package(SDL2 REQUIRED)
find_package(OpenGL REQUIRED)


add_executable(microui main.cpp	microui.c microui.h)
add_executable(microuisdl mainsdldemo.cpp microui.c microui.h renderer.cpp renderer.h)
target_include_directories(microuisdl PRIVATE ${SDL2_INCLUDE_DIRS}  ${OPENGL_INCLUDE_DIRS})
target_link_libraries(microuisdl ${SDL2_LIBRARIES} ${OPENGL_LIBRARIES} )
