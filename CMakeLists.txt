cmake_minimum_required(VERSION 3.15)
project(compressor C)

set(CMAKE_C_FLAGS "-Wall -Wextra -Wpedantic -Werror ${CMAKE_C_FLAGS}")

find_package(ZLIB REQUIRED)

file(GLOB SOURCES "src/*.c")

add_executable(${PROJECT_NAME} ${SOURCES})
target_link_libraries(${PROJECT_NAME} ZLIB::ZLIB)
