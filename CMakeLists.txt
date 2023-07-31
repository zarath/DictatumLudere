cmake_minimum_required(VERSION 3.16)

project(dictatumludere VERSION 1.0.2 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_PREFIX_PATH /home/hmueller/Qt/6.5.2/gcc_64/lib/cmake/Qt6)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick Multimedia)

if(ANDROID)
    add_library(dictatumludere SHARED main.cpp dssloader.cpp footpaddle.cpp qml.qrc)
else()
    add_executable(dictatumludere main.cpp dssloader.cpp footpaddle.cpp qml.qrc)
    set_property(TARGET dictatumludere PROPERTY WIN32_EXECUTABLE true)
endif()

target_compile_definitions(dictatumludere
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(dictatumludere
  PRIVATE Qt6::Core Qt6::Quick Qt6::Multimedia)

install(TARGETS dictatumludere
  DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
  )


  # QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check http://doc.qt.io/qt-5/deployment-android.html for more information.
# These variables must use CACHE, otherwise QtCreator won't see them.

#if(ANDROID)
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android" CACHE INTERNAL "")
#    if (ANDROID_ABI STREQUAL "armeabi-v7a")
#        set(ANDROID_EXTRA_LIBS ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so CACHE INTERNAL "")
#    endif()
#endif()
