project (Batch6 CXX)

set( ${PROJECT_NAME}_SOURCES
		Batch6Main.cpp
	)
set( ${PROJECT_NAME}_PUBLIC_HEADERS
		Batch6.h
	)
	

set(${PROJECT_NAME}_BUILD_EXECUTABLE ON )
set(${PROJECT_NAME}_TO_INSTALL ON )

set(${PROJECT_NAME}_WARNINGS_AS_ERRORS OFF)
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

set(${PROJECT_NAME}_LINKER_DEPENDENCY 
				CONAN_PKG::sdl2  
				CONAN_PKG::freetype 
				CONAN_PKG::glm
				CONAN_PKG::glew
		)

manage_target_options(${PROJECT_NAME}  )
set_target_properties(${PROJECT_NAME}  PROPERTIES FOLDER "Batch")


#  target_compile_definitions(${PROJECT_NAME} PRIVATE   NEWLIB_THREAD_SAFE  )  #No need for  the -D
#  target_compile_options(${PROJECT_NAME} PRIVATE -O0 -g -fprofile-arcs -ftest-coverage)
#  target_link_options(${PROJECT_NAME} PRIVATE -fprofile-arcs -ftest-coverage)