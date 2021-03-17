project (Batch1 CXX)

set( sources
		Batch1Main.cpp
	)
set( headers
		Batch1.h
	)
	

option(${PROJECT_NAME}_BUILD_EXECUTABLE  "If we want an execultable" ON)
option(${PROJECT_NAME}_BUILD_HEADERS_ONLY  "If we want an header only" OFF)
option(${PROJECT_NAME}_BUILD_STATIC_LIB "If we want a static lib" OFF)

option(${PROJECT_NAME}_ENABLE_UNIT_TESTING "If we have a test unit in a folder named 'test'" OFF)

#if not set, each of these will use the globals option in /CMake/GlobalOptions
if(MSVC)
set(${PROJECT_NAME}_COMPILER_DEFINITION "")
set(${PROJECT_NAME}_COMPILER_DEBUG_DEFINITION "")
set(${PROJECT_NAME}_COMPILER_RELEASE_DEFINITION "")
set(${PROJECT_NAME}_COMPILER_OPTIONS "")
set(${PROJECT_NAME}_COMPILER_DEBUG_OPTIONS "")
set(${PROJECT_NAME}_COMPILER_RELEASE_OPTIONS "")
set(${PROJECT_NAME}_LINKER_OPTIONS "")
set(${PROJECT_NAME}_LINKER_DEBUG_OPTIONS "")
set(${PROJECT_NAME}_LINKER_RELEASE_OPTIONS "")
else()
set(${PROJECT_NAME}_COMPILER_DEFINITION "")
set(${PROJECT_NAME}_COMPILER_DEBUG_DEFINITION "")
set(${PROJECT_NAME}_COMPILER_RELEASE_DEFINITION "")
set(${PROJECT_NAME}_COMPILER_OPTIONS "")
set(${PROJECT_NAME}_COMPILER_DEBUG_OPTIONS "")
set(${PROJECT_NAME}_COMPILER_RELEASE_OPTIONS "")
set(${PROJECT_NAME}_LINKER_OPTIONS "")
set(${PROJECT_NAME}_LINKER_DEBUG_OPTIONS "")
set(${PROJECT_NAME}_LINKER_RELEASE_OPTIONS "")
endif()

set(${PROJECT_NAME}_LINKER_DEPENDECY "ofFile")

manage_targetOptions(${PROJECT_NAME} ${headers} ${sources})


#  target_compile_definitions(${PROJECT_NAME} PRIVATE   NEWLIB_THREAD_SAFE  )  #No need for  the -D
#  target_compile_options(${PROJECT_NAME} PRIVATE -O0 -g -fprofile-arcs -ftest-coverage)
#  target_link_options(${PROJECT_NAME} PRIVATE -fprofile-arcs -ftest-coverage)