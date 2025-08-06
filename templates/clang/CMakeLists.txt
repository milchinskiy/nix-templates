cmake_minimum_required(VERSION 3.16)
project(simple-project LANGUAGES C)

set(CMAKE_C_COMPILER clang)
set(CMAKE_C_STANDARD 11)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_compile_options(-Wall -Wextra -Wpedantic -Werror)
set(CMAKE_C_FLAGS_DEBUG "-g -DDEBUG")

# Find Cairo and Wayland
find_package(PkgConfig REQUIRED)
# pkg_check_modules(CAIRO REQUIRED some-lib)

include_directories(
  # additional includes
)

link_directories(
  # additional libs
)

add_executable(simple-project src/main.c)
