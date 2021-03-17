project (Batch4Test CXX)

set( sources
		Batch4_TestMain.cpp
	)
set( headers
		../Batch4.h
	)
	

set(${PROJECT_NAME}_BUILD_EXECUTABLE ON )

set(${PROJECT_NAME}_WARNINGS_AS_ERRORS OFF)

#You can also add your own compiler/linker option and definition
if(MSVC)
set(${PROJECT_NAME}_COMPILER_DEFINITION "")
set(${PROJECT_NAME}_COMPILER_DEFINITION_DEBUG "")
set(${PROJECT_NAME}_COMPILER_DEFINITION_RELEASE "")
set(${PROJECT_NAME}_COMPILER_OPTIONS "")
set(${PROJECT_NAME}_COMPILER_OPTIONS_DEBUG "")
set(${PROJECT_NAME}_COMPILER_OPTIONS_RELEASE "")
set(${PROJECT_NAME}_LINKER_OPTIONS "")
set(${PROJECT_NAME}_LINKER_OPTIONS_DEBUG "")
set(${PROJECT_NAME}_LINKER_OPTIONS_RELEASE "")
elseif(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang" AND NOT ${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")

elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")

endif()

set(${PROJECT_NAME}_LINKER_DEPENDECY ofBatch CONAN_PKG::gtest)

manage_target_options(${PROJECT_NAME} ${headers} ${sources})

#We need to specify that this is a test
add_test(
  NAME     
    ${PROJECT_NAME}
  COMMAND
    ${PROJECT_NAME}
)



#  target_compile_definitions(${PROJECT_NAME} PRIVATE   NEWLIB_THREAD_SAFE  )  #No need for  the -D
#  target_compile_options(${PROJECT_NAME} PRIVATE -O0 -g -fprofile-arcs -ftest-coverage)
#  target_link_options(${PROJECT_NAME} PRIVATE -fprofile-arcs -ftest-coverage)