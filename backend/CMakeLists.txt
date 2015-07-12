include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
    /usr/include/libxml2
)

set(
    Lonewolfbackend_SRCS
    modules/Lonewolf/backend.cpp
    modules/Lonewolf/book.cpp
    modules/Lonewolf/downloader.cpp
    modules/Lonewolf/util.cpp
)

# Make the unit test files visible on qtcreator
add_custom_target(Lonewolfbackend_UNITTEST_QML_FILES ALL SOURCES "tests/unit/tst_mytype.qml")

add_library(Lonewolfbackend MODULE
    ${Lonewolfbackend_SRCS}
)

set_target_properties(Lonewolfbackend PROPERTIES
         LIBRARY_OUTPUT_DIRECTORY Lonewolf)

target_link_libraries(Lonewolfbackend
    xml2
)

qt5_use_modules(Lonewolfbackend Gui Qml Quick XmlPatterns)

# Copy qmldir file to build dir for running in QtCreator
add_custom_target(Lonewolfbackend-qmldir ALL
    COMMAND cp ${CMAKE_CURRENT_SOURCE_DIR}/modules/Lonewolf/qmldir ${CMAKE_CURRENT_BINARY_DIR}/Lonewolf
    DEPENDS ${QMLFILES}
)

# Install plugin file
install(TARGETS Lonewolfbackend DESTINATION ${QT_IMPORTS_DIR}/Lonewolf/)
install(FILES   modules/Lonewolf/qmldir DESTINATION ${QT_IMPORTS_DIR}/Lonewolf/)

