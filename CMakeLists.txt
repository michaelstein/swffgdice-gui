cmake_minimum_required(VERSION 3.12)
project(swffgdice-gui)

# basic cmake settings
set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${PROJECT_SOURCE_DIR}/cmake")
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# compiler settings
if(WIN32)
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /MP")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP /W4")
	add_definitions(-D_CRT_SECURE_NO_WARNINGS)
endif(WIN32)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Include Conan build files
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup(TARGETS)

# global include settings
include_directories(${PROJECT_SOURCE_DIR}/src)
include_directories(${CONAN_INCLUDE_DIRS_GSL_MICROSOFT})

# Qt6
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 COMPONENTS
	#Widgets REQUIRED
	Quick REQUIRED
	QuickControls2 REQUIRED
)

# Source
file(GLOB_RECURSE headers src/*.h)
file(GLOB_RECURSE sources src/*.cpp)
file(GLOB_RECURSE qtforms res/ui/*.ui)
set(qtres res/res.qrc)

source_group(
	TREE ${CMAKE_CURRENT_SOURCE_DIR}
	PREFIX src
	FILES ${headers} ${sources}
)

source_group("headers"    FILES ${changes_HEADERS})
source_group("qt_headers" FILES ${changes_QHEADERS})
source_group("qt_moc"     FILES ${changes_QHEADERS_MOC})
source_group("qt_form"    FILES ${changes_QFORMS_HEADER})
source_group("qt_res"     FILES ${changes_QRESOURCES_RCC})

include_directories(src)

link_directories(
	${CMAKE_CURRENT_BINARY_DIR}
)

if(WIN32)
	set(GUI_TYPE WIN32)
	#list(APPEND changes_SOURCES changes.rc)
endif(WIN32)
if(APPLE)
	set(GUI_TYPE MACOSX_BUNDLE)
endif(APPLE)

# Target
add_executable(${PROJECT_NAME}
	${GUI_TYPE}
	${headers}
	${sources}
	${qtforms}
	${qtforms_generated}
	${qtres}
)

target_link_libraries(${PROJECT_NAME}
	#PRIVATE Qt6::Widgets
	PRIVATE Qt6::Quick
	PRIVATE Qt6::QuickControls2
	PRIVATE CONAN_PKG::swffgdice
)

#set_target_properties(${PROJECT_NAME} PROPERTIES
#	QT_QML_MODULE_VERSION 1.0
#	QT_QML_MODULE_URI mstein.swffgdice
#)
#qt6_qml_type_registration(${PROJECT_NAME})

if(WIN32)
	target_link_libraries(${PROJECT_NAME}
		PRIVATE Ws2_32.lib
	)
endif(WIN32)

if(UNIX)
	target_link_libraries(${PROJECT_NAME}
		PRIVATE pthread
	)
endif(UNIX)

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_if_different "${PROJECT_SOURCE_DIR}/res/qt.conf" $<TARGET_FILE_DIR:${PROJECT_NAME}>)
