cmake_minimum_required(VERSION 3.5)

project(abh_gui_v3 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_compile_options(-funroll-loops -Wall -Ofast)
set(CMAKE_BUILD_TYPE Release)
# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check http://doc.qt.io/qt-5/deployment-android.html for more information.
# They need to be set before the find_package(Qt5 ...) call.

#if(ANDROID)
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    if (ANDROID_ABI STREQUAL "armeabi-v7a")
#        set(ANDROID_EXTRA_LIBS
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
#    endif()
#endif()

find_package(Qt5 COMPONENTS Core Quick Multimedia Widgets Qml DBus Network REQUIRED)
find_package(Boost 1.40.0 REQUIRED system thread regex)
find_package( OpenCV REQUIRED )


#QtDBus QtNetwork

include_directories(
   ${Boost_INCLUDE_DIRS}
)

SET(APP_FILES
  qml.qrc
  main.cpp
  QmlStringUdpReceiver.cpp
  QmlStringUdpSender.cpp
  QmlBinaryUdpReceiver.cpp
  QmlBinaryUdpSender.cpp
  UdpVideoStream.cpp
  PracticalSocket.cpp
  ListaNome.cpp
  ListaImmagini.cpp
  ListStringCSV.cpp
  ListStringQueue.cpp
  ListaUtenti.cpp
  ProgrammaAllenamento.cpp
  DescrizioneEsercizi.cpp
  areachart.cpp
  ChiamataSistema.cpp
  listwifi.cpp
  stringquee.cpp
  )

if(ANDROID)
    add_library(abh_gui_v3 SHARED
        ${APP_FILES}
    )
else()
    add_executable(abh_gui_v3
        ${APP_FILES}
    )
endif()

target_compile_definitions(abh_gui_v3
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(abh_gui_v3
  PRIVATE Qt5::Core Qt5::Quick  Qt5::Multimedia Qt5::Widgets Qt5::Qml  Qt5::DBus Qt5::Network  ${Boost_LIBRARIES} ${OpenCV_LIBS} )
