function(verbose_message content)
    if(VERBOSE_OUTPUT)
			message(STATUS ${content})
    endif()
endfunction()


#we set the specific option for each target
function(manage_targetOptions target_name headers sources)

	if(${target_name}_BUILD_EXECUTABLE)
		add_executable(
			${target_name} 
			${sources} 
			${headers}
		)
	elseif(${target_name}_BUILD_HEADERS_ONLY)
		add_library(
			${target_name} 
			INTERFACE
			)
	elseif(${target_name}_BUILD_STATIC_LIB)
		add_library(
			${target_name}
			STATIC
			${headers}
			${sources}
			)
	else()
		add_library(
			${target_name}
			SHARED
			${headers}
			${sources}
		)
	endif()
	
	#  target_compile_definitions(${PROJECT_NAME} PRIVATE   NEWLIB_THREAD_SAFE  )  #No need for  the -D
	#  target_compile_options(${PROJECT_NAME} PRIVATE -O0 -g -fprofile-arcs -ftest-coverage)
	#  target_link_options(${PROJECT_NAME} PRIVATE -fprofile-arcs -ftest-coverage)

	
	if(${PROJECT_NAME}_BUILD_HEADERS_ONLY)
		target_compile_features(${PROJECT_NAME} INTERFACE cxx_std_11)
	else()
		target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_11)
	endif()
	
	target_include_directories(
		${target_name}
		PUBLIC 
		$<INSTALL_INTERFACE:include>    
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
	)
	
	
	verbose_message("Finished set include_directories for target ${target_name}")

	
	target_link_libraries(${PROJECT_NAME} PUBLIC ${${PROJECT_NAME}_LINKER_DEPENDECY})
	 
	if(ENABLE_CONAN)
		target_include_directories(${target_name} PUBLIC ${CONAN_INCLUDE_DIRS} ) 
	endif()
	
	if(${target_name}_ENABLE_UNIT_TESTING)
		enable_testing()
		message("Build unit tests for the project. Tests should always be found in the test folder\n")
		add_subdirectory(test)
	endif()
	
	
	

endfunction()