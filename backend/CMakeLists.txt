include_directories(
    ${LIBXML_INCLUDE_DIRS}
)

link_libraries(
    ${LIBXML_LDFLAGS}
)

add_library(Lonewolfbackend MODULE
    backend.cpp
    book.cpp
    downloader.cpp
    util.cpp
)

qt5_use_modules(Lonewolfbackend Gui Qml Quick XmlPatterns)

# Install plugin file

execute_process(
    COMMAND dpkg-architecture -qDEB_HOST_MULTIARCH
    OUTPUT_VARIABLE ARCH_TRIPLET
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

install(TARGETS Lonewolfbackend DESTINATION lib/${ARCH_TRIPLET}/Lonewolf/)
install(FILES qmldir DESTINATION lib/${ARCH_TRIPLET}/Lonewolf/)
