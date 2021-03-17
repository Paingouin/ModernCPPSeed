function(verbose_message content)
    if(VERBOSE_OUTPUT)
			message(STATUS ${content})
    endif()
endfunction()


#we set the specific option for each target
function(manage_target_options target_name headers sources)

	if(${${target_name}_BUILD_EXECUTABLE})
		add_executable(
			${target_name} 
			${sources} 
			${headers}
		)
	elseif(${${target_name}_BUILD_HEADERS_ONLY})
		add_library(
			${target_name} 
			INTERFACE
			)
	elseif(${${target_name}_BUILD_STATIC_LIB})
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
	
	
	set_project_warnings(${target_name})
	verbose_message("Finished set project warning for ${target_name}")
	
	set_project_compile_options(${target_name})
	verbose_message("Finished set compile options for ${target_name}")
	
	## Export all symbols when building a shared library
	#if(${PROJECT_NAME}_BUILD_SHARED_LIBS)
	#	set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS OFF)
	#	set(CMAKE_CXX_VISIBILITY_PRESET hidden)
	#	set(CMAKE_VISIBILITY_INLINES_HIDDEN 1)
	#endif()
	#
	##LTO
	#if(${PROJECT_NAME}_ENABLE_LTO)
	#	include(CheckIPOSupported)
	#	check_ipo_supported(RESULT result OUTPUT output)
	#	if(result)
	#		set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
	#	else()
	#		message(SEND_ERROR "IPO is not supported: ${output}.")
	#	endif()
	#endif()
	
	if(${${target_name}_BUILD_HEADERS_ONLY})
		target_compile_features(${target_name} INTERFACE cxx_std_11)
	else()
		target_compile_features(${target_name} PUBLIC cxx_std_11)
	endif()
	
	target_include_directories(
		${target_name}
		PUBLIC 
		$<INSTALL_INTERFACE:include>    
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
	)
	
	verbose_message("Finished set include_directories for ${target_name}")

	
	target_link_libraries(${target_name} PUBLIC ${${target_name}_LINKER_DEPENDECY})
	 
	if(ENABLE_CONAN)
		target_include_directories(${target_name} PUBLIC ${CONAN_INCLUDE_DIRS} ) 
	endif()
	
	if(${${target_name}_ENABLE_UNIT_TESTING})
		enable_testing()
		message( STATUS "Build unit tests for the project. Tests should always be found in the test subfolder\n")
		add_subdirectory(test)
	endif()
	
	
	install(
		TARGETS
			${target_name}
		EXPORT
			${target_name}Targets
		LIBRARY DESTINATION
			${CMAKE_INSTALL_LIBDIR}
		RUNTIME DESTINATION
			${CMAKE_INSTALL_BINDIR}
		ARCHIVE DESTINATION
			${CMAKE_INSTALL_LIBDIR}
		INCLUDES DESTINATION
			include
		PUBLIC_HEADER DESTINATION
			include
		)

	install(
		EXPORT 
			${target_name}Targets
		FILE		
			${target_name}Targets.cmake
		NAMESPACE
			${target_name}::
		DESTINATION
			${CMAKE_INSTALL_LIBDIR}/cmake/${target_name}
		)
	
endfunction()