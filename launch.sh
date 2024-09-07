#!/bin/bash

BIN=compressor
WORKDIR=$(pwd)
BUILD=build
CONFIG=Release

function usage() {
  echo "Usage: ./launch.sh <ARG>"
  echo "  <ARG> may be one of:  "
  echo "  - profile             "
  echo "  - build               "
  echo "  - run                 "
  echo "  - doit                "
  echo "  - clean               "
}

function build() {
  cd $WORKDIR
  echo "Building into $BUILD/..."
  conan install . --output-folder=$BUILD --build=missing
  echo "Entering $BUILD/..."
  cd $BUILD
  # export CMAKE_GENERATOR="Visual Studio 17 2022" to set default for CMake>=3.15
  echo "Generating build system using env CMAKE_GENERATOR=$CMAKE_GENERATOR..."
  cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake
  echo "Building with $CONFIG..."
  cmake --build . --config $CONFIG
  echo "Build finished."
}

function run() {
  cd $WORKDIR
  echo "Running with $CONFIG..."
  echo ""
  ./$BUILD/$CONFIG/$BIN.exe
}

function clean() {
  cd $WORKDIR
  echo "Cleaning..."
  rm -r build/
  rm CMakeUserPresets.json
  echo "Cleaned!"
}

case $1 in
  profile)
    echo "Detecting profile..."
    conan profile detect --force
    ;;
  build)
    build
    ;;
  run)
    run
    ;;
  doit)
    build
    run
    ;;
  clean)
    clean
    ;;
  *)
    usage
    ;;
esac