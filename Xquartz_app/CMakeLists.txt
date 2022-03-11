cmake_minimum_required(VERSION 3.11)
project(xquartapp)

include_directories(/opt/X11/include
		)

add_executable(xquartapp
main.cpp
		)
target_link_directories(xquartapp PRIVATE /opt/X11/lib)
target_link_libraries(xquartapp glut GL GLU X11)