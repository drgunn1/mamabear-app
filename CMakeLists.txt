cmake_minimum_required(VERSION 3.16)

project(mamabear VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS Quick)
find_package(Qt6 6.2 REQUIRED COMPONENTS Widgets)
find_package(Qt6 6.2 REQUIRED COMPONENTS Mqtt)
find_package(Qt6 6.2 REQUIRED COMPONENTS Multimedia)

qt_add_executable(appMamabear
    main.cpp
)

qt_add_qml_module(appMamabear
    URI mamabear
    VERSION 1.0
    NO_RESOURCE_TARGET_PATH
    QML_FILES main.qml
    QML_FILES MainView.qml
    QML_FILES SensorData.qml
    QML_FILES Triangle.qml
    SOURCES MqttSubscriber.h MqttSubscriber.cpp
    RESOURCES resources/nxp-logo.svg
    RESOURCES resources/future-electronics.svg
    RESOURCES resources/thermometer.png
    RESOURCES resources/humidity.png
    RESOURCES resources/camera.png
    RESOURCES resources/gyroscope.png
    RESOURCES resources/voc.png
    RESOURCES resources/microphone.png
    RESOURCES resources/distance.png
    RESOURCES resources/stub_video.mp4
)

set_target_properties(appMamabear PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appMamabear
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appMamabear
    PRIVATE Qt6::Quick)
target_link_libraries(appMamabear
    PRIVATE Qt6::Widgets)
target_link_libraries(appMamabear
    PRIVATE Qt6::Mqtt)
