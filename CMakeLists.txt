cmake_minimum_required(VERSION 3.15)
project(compressor C)

set(CMAKE_C_STANDARD 11)

if(CMAKE_COMPILER_IS_GNUCC)
  message(STATUS "gcc detected, adding specific flags")
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra -Wpedantic -Werror")
else()
  message(STATUS "Detected non-gcc compiler, omitting some flags")
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall")
endif(CMAKE_COMPILER_IS_GNUCC)

find_package(ZLIB REQUIRED)

file(GLOB SOURCES "src/*.c")

add_executable(${PROJECT_NAME} ${SOURCES})

target_link_libraries(${PROJECT_NAME} ZLIB::ZLIB)

# target_include_directories(${PROJECT_NAME} PUBLIC include)
