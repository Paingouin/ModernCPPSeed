function(verbose_message content)
    if(VERBOSE_OUTPUT)
			message(STATUS ${content})
    endif()
endfunction()

function(add_clang_format_target)
	find_program(CLANG_FORMAT_BINARY clang-format)
    if(CLANG_FORMAT_BINARY)
		add_custom_target(clang-format
				COMMAND ${CLANG_FORMAT_BINARY}
				-i ${CMAKE_CURRENT_LIST_DIR}= ${CMAKE_CURRENT_LIST_DIR}/${headers})

		message(STATUS "Format the projects using the `clang-format` target (i.e: cmake --build build --target clang-format).\n")
    endif()
endfunction()

include(GoogleTest)
include(CMakePackageConfigHelpers)
# Install library for easy downstream inclusion  (move to bin the exe etc..)
include(GNUInstallDirs)


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
		## Export all symbols when building a shared library
		#if(${PROJECT_NAME}_BUILD_SHARED_LIBS)
		#	set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS OFF)
		#	set(CMAKE_CXX_VISIBILITY_PRESET hidden)
		#	set(CMAKE_VISIBILITY_INLINES_HIDDEN 1)
		#endif()
	endif()
	
	#  target_compile_definitions(${PROJECT_NAME} PRIVATE   NEWLIB_THREAD_SAFE  )  #No need for  the -D
	#  target_compile_options(${PROJECT_NAME} PRIVATE -O0 -g -fprofile-arcs -ftest-coverage)
	#  target_compile_features()
	#  target_link_options(${PROJECT_NAME} PRIVATE -fprofile-arcs -ftest-coverage)
	

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
	verbose_message("Finished set library dependency for ${target_name}")
	
	
	#Compile option	
	target_link_libraries(${target_name} PRIVATE $<BUILD_INTERFACE:project_global_options>)
	
	set( DEFINE_OPTION  "")
    set( COMPILE_OPTION "")
	set( LINKER_OPTION  "")
	
	#add user optionnal option
	set( DEFINE_OPTION ${DEFINE_OPTION} 
			${${target_name}_COMPILER_DEFINITION}
			$<IF:$<CONFIG:DEBUG>,${${target_name}_COMPILER_DEFINITION_DEBUG},${${target_name}_COMPILER_DEFINITION_RELEASE}>
		)
		
	set( COMPILE_OPTION ${COMPILE_OPTION} 
			${${target_name}_COMPILER_OPTIONS}
			$<IF:$<CONFIG:DEBUG>,${${target_name}_COMPILER_OPTIONS_DEBUG},${${target_name}_COMPILER_OPTIONS_RELEASE}>
		)
	set( LINKER_OPTION ${LINKER_OPTION} 
			${${target_name}_LINKER_DEFINITION}
			$<IF:$<CONFIG:DEBUG>,${${target_name}_LINKER_OPTIONS_DEBUG},${${target_name}_LINKER_OPTIONS_RELEASE}>
		)
	
	#Add them to the  project target
	target_compile_definitions(${target_name} PRIVATE 
			 ${DEFINE_OPTION}
		 )
		 
	target_compile_options(${target_name} PRIVATE 
		     ${COMPILE_OPTION} 
			 ${LINKER_OPTION}
		 )
	verbose_message("Finished set compile options for ${target_name}")
	
	target_link_libraries(${target_name} PRIVATE $<BUILD_INTERFACE:project_global_warnings>)
	verbose_message("Finished set project warning for ${target_name}")
	 
	#if(ENABLE_CONAN)
	#	target_include_directories(${target_name} PUBLIC ${CONAN_INCLUDE_DIRS} ) 
	#endif()
		
	
	if(${${target_name}_ENABLE_UNIT_TESTING})
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
		
	# Quick `ConfigVersion.cmake` creation
	#write_basic_package_version_file(
	#	${target_name}ConfigVersion.cmake
	#VERSION
	#	${PROJECT_VERSION} #to test
	#COMPATIBILITY
	#	SameMajorVersion
	#)
	#configure_package_config_file(
	#		${CMAKE_CURRENT_LIST_DIR}/cmake/${target_name}Config.cmake.in
	#		${CMAKE_CURRENT_BINARY_DIR}/${target_name}Config.cmake
	#	INSTALL_DESTINATION 
	#		${CMAKE_INSTALL_LIBDIR}/cmake/${target_name}
	#)
	
	#install(
	#	FILES
	#	${CMAKE_CURRENT_BINARY_DIR}/${target_name}Config.cmake
	#	${CMAKE_CURRENT_BINARY_DIR}/${target_name}ConfigVersion.cmake
	#DESTINATION
	#	${CMAKE_INSTALL_LIBDIR}/cmake/${target_name}
	#)

	# Generate export header if specified
	#if(${target_name}_GENERATE_EXPORT_HEADER)
	#	include(GenerateExportHeader)
	#	generate_export_header(${target_name})
	#	install(
	#		FILES
	#			${PROJECT_BINARY_DIR}/${target_name}_export.h 
	#		DESTINATION
	#			include
	#	)
	#	message("Generated the export header `${target_name}_export.h` and installed it.")
	#endif()
	
	
endfunction()