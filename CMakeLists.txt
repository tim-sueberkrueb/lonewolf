project(lonewolf CXX)
cmake_minimum_required(VERSION 2.8.9)

find_package(PkgConfig)
find_package(Qt5Core)
find_package(Qt5Qml)
find_package(Qt5Quick)

pkg_check_modules(LIBXML REQUIRED libxml-2.0)

set(CMAKE_AUTOMOC ON)

add_definitions(-std=c++14)

install(FILES LICENSE README.md DESTINATION /)
install(DIRECTORY app/ DESTINATION /)

add_subdirectory(backend)
