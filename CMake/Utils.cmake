#doc : 
# https://gitlab.kitware.com/cmake/community/-/wikis/home
# https://cmake.org/cmake/help/latest/manual/cmake.1.html 
# https://github.com/Akagi201/learning-cmake
# https://gist.github.com/mbinna/c61dbb39bca0e4fb7d1f73b0d66a4fd1 - Effective CMake online book
# https://pabloariasal.github.io/2018/02/19/its-time-to-do-cmake-right/
# https://cliutils.gitlab.io/modern-cmake/ - An Introduction to Modern CMake

include(GoogleTest)
include(CMakePackageConfigHelpers)

# Install library for easy downstream inclusion  (move to bin the exe etc..)
include(GNUInstallDirs)

# Install runtime dependency 
#include(InstallRequiredSystemLibraries)
#set(CMAKE_INSTALL_MFC_LIBRARIES TRUE)


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
				-i ${CMAKE_CURRENT_LIST_DIR}= ${CMAKE_CURRENT_LIST_DIR}/${${target_name}_PUBLIC_HEADERS})

		message(STATUS "Format the projects using the `clang-format` target (i.e: cmake --build build --target clang-format).\n")
    endif()
endfunction()




#we set the specific option for each target
function(manage_target_options target_name)

	if(${${target_name}_BUILD_EXECUTABLE})
		add_executable(
			${target_name} 
			 $<BUILD_INTERFACE:${${target_name}_SOURCES}>
			 $<BUILD_INTERFACE:${${target_name}_PUBLIC_HEADERS}>
			 $<BUILD_INTERFACE:${${target_name}_PRIVATE_HEADERS}>
		)
		set_target_properties(
		${target_name} 
		PROPERTIES
			VS_DEBUGGER_WORKING_DIRECTORY "$<TARGET_FILE_DIR:${target_name}>"
		)

		verbose_message("Add target source for ${${target_name}_SOURCES} ${${target_name}_PUBLIC_HEADERS} ${${target_name}_PRIVATE_HEADERS}	")
		
	elseif(${${target_name}_BUILD_HEADERS_ONLY})
		add_library(
			${target_name} 
			INTERFACE		
		)
		
		 set_source_files_properties(
			${CMAKE_CURRENT_LIST_DIR}/${${target_name}_PUBLIC_HEADERS} 
				PROPERTIES HEADER_FILE_ONLY TRUE
		)
		 
		target_sources(
		    ${target_name}
			INTERFACE  
			./${${target_name}_PUBLIC_HEADERS}
		)		
		
		verbose_message("Add target source for ${${target_name}_PUBLIC_HEADERS}	")
	elseif(${${target_name}_BUILD_STATIC_LIB})
		add_library(
			${target_name}
			STATIC
			 $<BUILD_INTERFACE:${${target_name}_PUBLIC_HEADERS}>
			 $<BUILD_INTERFACE:${${target_name}_PRIVATE_HEADERS}>
			 $<BUILD_INTERFACE:${${target_name}_SOURCES}>
		)
			verbose_message("Add target source for ${${target_name}_SOURCES} ${${target_name}_PUBLIC_HEADERS} ${${target_name}_PRIVATE_HEADERS}	")
	else()
		add_library(
			${target_name}
			SHARED
			 ${${target_name}_PUBLIC_HEADERS}
			 ${${target_name}_PRIVATE_HEADERS}
			 ${${target_name}_SOURCES}
		)
			verbose_message("Add target source for ${${target_name}_SOURCES} ${${target_name}_PUBLIC_HEADERS} ${${target_name}_PRIVATE_HEADERS}	")
		## Export all symbols when building a shared library
		#if(${PROJECT_NAME}_BUILD_SHARED_LIBS)
		#	set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS OFF)
		#	set(CMAKE_CXX_VISIBILITY_PRESET hidden)
		#	set(CMAKE_VISIBILITY_INLINES_HIDDEN 1)
		#endif()
	endif()
	
	set_target_properties(${PROJECT_NAME} PROPERTIES DEBUG_POSTFIX "d")
	

	if(${${target_name}_BUILD_HEADERS_ONLY})
		target_compile_features(${target_name} INTERFACE cxx_std_11)
		target_include_directories(
		${target_name} 
		INTERFACE
		 $<BUILD_INTERFACE:${${target_name}_SOURCE_DIR}> 
		 $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
		)
		verbose_message("Add target include directories from ${${target_name}_SOURCE_DIR}")
	else()
		target_compile_features(${target_name} PUBLIC cxx_std_11)
		target_include_directories(
		${target_name}
		PUBLIC 
		$<BUILD_INTERFACE:${${target_name}_SOURCE_DIR}>
		$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>	
		)
		verbose_message("Add target include directories from ${${target_name}_SOURCE_DIR}")
	endif()
	
	if(${${target_name}_INSTALL_HEADER} ) 
		set_target_properties( ${target_name} PROPERTIES PUBLIC_HEADER "${${target_name}_PUBLIC_HEADERS}" )
	endif()
	
	
	verbose_message("Finished set include_directories for ${target_name}")

	if(${${target_name}_BUILD_HEADERS_ONLY})
		target_link_libraries(${target_name} INTERFACE 
			${${target_name}_LINKER_DEPENDENCY}
		)
	else()
		target_link_libraries(${target_name} PUBLIC 
			${${target_name}_LINKER_DEPENDENCY}
		)
		target_link_libraries(${target_name} PRIVATE
			 $<BUILD_INTERFACE:project_global_options>
		)
		
		verbose_message("Finished set library dependency ${${target_name}_LINKER_DEPENDENCY} ")

	endif()
	verbose_message("Finished set library dependency for ${target_name}")
	
	
	#add_dependencies(${target_name} copy_ressources)
	
	if( NOT ${${target_name}_BUILD_HEADERS_ONLY})
		
		set( DEFINE_OPTION  "")
		set( COMPILE_OPTION "")
		set( LINKER_OPTION  "")
		
		#add user optionnal option
		set( DEFINE_OPTION ${DEFINE_OPTION} 
				${${target_name}_COMPILER_DEFINITION}
				$<IF:$<CONFIG:DEBUG>,${${target_name}_COMPILER_DEFINITION_DEBUG}
						,${${target_name}_COMPILER_DEFINITION_RELEASE}>
			)
		set( COMPILE_OPTION ${COMPILE_OPTION} 
				${${target_name}_COMPILER_OPTIONS}
				$<IF:$<CONFIG:DEBUG>,${${target_name}_COMPILER_OPTIONS_DEBUG}
						,${${target_name}_COMPILER_OPTIONS_RELEASE}> 
			)
		set( LINKER_OPTION ${LINKER_OPTION} 
				${${target_name}_LINKER_DEFINITION}
				$<IF:$<CONFIG:DEBUG>,${${target_name}_LINKER_OPTIONS_DEBUG}
						,${${target_name}_LINKER_OPTIONS_RELEASE}>
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
		
		##target_link_libraries(${target_name} PRIVATE  
		##	$<BUILD_INTERFACE:project_global_warnings>
		##)
		verbose_message("Finished set project warning for ${target_name}")
	endif()
	
		
	if((${${target_name}_ENABLE_UNIT_TESTING}) AND (ENABLE_CONAN))
		message( STATUS "Build unit tests for the project. Tests should always be found in the test subfolder\n")
		add_subdirectory(test)
	endif()
	
	if(${${target_name}_TO_INSTALL})
		
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
				${CMAKE_INSTALL_INCLUDEDIR}/${target_name}
			PUBLIC_HEADER DESTINATION
				${CMAKE_INSTALL_INCLUDEDIR}/${target_name}
			)
			
			
		install( 
				FILES 
					${CMAKE_SOURCE_DIR}/CMake/ConanConfig/ConanRecipe/conanfile.py
			    DESTINATION
					${CMAKE_INSTALL_PREFIX}
			)

			
			### This makes the project importable from the install directory
			# Put config file in per-project dir (name MUST match), can also
			# just go into 'cmake'.
			#install(EXPORT AtuinConfig DESTINATION cmake)
	
			# This makes the project importable from the build directory
			#export(TARGETS ${PROJECT_NAME} FILE AtuinConfig.cmake)
	endif()
	
	#Below doesn't work with header only lib
	#install(
	#	EXPORT 
	#		${target_name}Targets
	#	FILE		
	#		${target_name}Targets.cmake
	#	NAMESPACE
	#		${target_name}::
	#	DESTINATION
	#		${CMAKE_INSTALL_LIBDIR}/cmake/${target_name}
	#	)
	
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



include(FetchContent)
function(get_source_from_svn_repo)
if(NOT ${SPECIFIC_CLIENT} STREQUAL "" AND NOT ${SPECIFIC_BRANCH} STREQUAL "")
    FetchContent_Declare(svn_repo
        SVN_REPOSITORY ""
		SVN_USERNAME "${SPECIFIC_SVN_USER}"
        SVN_PASSWORD "${SPECIFIC_SVN_PWD}"
        SVN_TRUST_CERT 1
        SOURCE_DIR "../svn_folder"
    )
    FetchContent_Populate(svn_folder)
    add_subdirectory(svn_folder)
endif()
endfunction()


function(copy_extlib_content)

endfunction()
