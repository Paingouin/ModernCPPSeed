project (ofBatch CXX)

set( sources
		ofBatch.cpp
	)
set( headers
		ofBatch.h
	)
	

set(${PROJECT_NAME}_BUILD_STATIC_LIB ON )

set(${PROJECT_NAME}_ENABLE_UNIT_TESTING OFF)


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

set(${PROJECT_NAME}_LINKER_DEPENDECY ofFile)

manage_target_options(${PROJECT_NAME} ${headers} ${sources})

#you can still now do things like :
#target_link_libraries(${PROJECT_NAME}  CONAN_PKG::Thot)
#but please keep it clean