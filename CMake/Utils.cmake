#CMAKE_BINARY_DIR : if you are building in-source, this is the same
#as CMAKE_SOURCE_DIR, otherwise this is the top level directory of
#your build tree
#
#CMAKE_COMMAND : this is the complete path of the cmake which runs
#currently (e.g. /usr/local/bin/cmake). Note that if you have
#custom commands that invoke cmake -E, it is very important to
#use CMAKE_COMMAND as the CMake executable, because CMake might not
#be on the system PATH.
#
#
#CMAKE_CURRENT_BINARY_DIR : if you are building in-source, this is
#the same as CMAKE_CURRENT_SOURCE_DIR, otherwise this is the
#directory where the compiled or generated files from the current
#CMakeLists.txt will go to.
#
#CMAKE_CURRENT_SOURCE_DIR : this is the directory where the
#currently processed CMakeLists.txt is located in
#
#CMAKE_CURRENT_LIST_FILE : this is the full path to the listfile
#currently being processed.
#
#CMAKE_CURRENT_LIST_DIR : (since 2.8.3) this is the directory
#of the listfile currently being processed.
#
#CMAKE_CURRENT_LIST_LINE : this is linenumber where the variable
#is used.
#
#CMAKE_FILES_DIRECTORY : the directory within the current binary
#directory that contains all the CMake generated files. Typically
#evaluates to "/CMakeFiles". Note the leading slash for the
#directory. Typically used with the current binary directory, i.e.
#${CMAKE_CURRENT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}
#
#CMAKE_MODULE_PATH : tell CMake to search first in directories
#listed in CMAKE_MODULE_PATH when you use FIND_PACKAGE() or
#INCLUDE()
#SET(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/MyCMakeScripts)
#FIND_PACKAGE(HelloWorld)
#
#CMAKE_ROOT : this is the CMake installation directory
#
#CMAKE_SOURCE_DIR : this is the directory which contains the
#top-level CMakeLists.txt, i.e. the top level source directory
#
#PROJECT_NAME : the name of the project set by PROJECT() command.
#
#CMAKE_PROJECT_NAME : the name of the first project set by the
#PROJECT() command, i.e. the top level project.
#
#PROJECT_BINARY_DIR : contains the full path to the top level
#directory of your build tree
#
#PROJECT_SOURCE_DIR : contains the full path to the root of your
#project source directory, i.e. to the nearest directory where
#CMakeLists.txt contains the PROJECT() command

#These are environment variables which effect cmake behaviour.

#CMAKE_INCLUDE_PATH : This is used when searching for include files
#e.g. using the FIND_PATH() command. If you have headers in
#non-standard locations, it may be useful to set this variable to
#this directory (e.g. /sw/include on Mac OS X). If you need several
#directories, separate them by the platform specific separators (e.g.
#":" on UNIX)
#
#CMAKE_LIBRARY_PATH : This is used when searching for libraries
#e.g. using the FIND_LIBRARY() command. If you have libraries in
#non-standard locations, it may be useful to set this variable to
#this directory (e.g. /sw/lib on Mac OS X). If you need several
#directories, separate them by the platform specific separators (e.g.
#":" on UNIX)
#
#CMAKE_PREFIX_PATH : (since CMake 2.6.0) This is used when
#searching for include files, binaries, or libraries using either the
#FIND_PACKAGE(), FIND_PATH(), FIND_PROGRAM(), or FIND_LIBRARY()
#commands. For each path in the CMAKE_PREFIX_PATH list, CMake will
#check "PATH/include" and "PATH" when FIND_PATH() is called,
#"PATH/bin" and "PATH" when FIND_PROGRAM() is called, and "PATH/lib"
#and "PATH" when FIND_LIBRARY() is called. See the documentation for
#FIND_PACKAGE(), FIND_LIBRARY(), FIND_PATH(), and FIND_PROGRAM()
#for more details.
#
#CMAKE_INSTALL_ALWAYS : If set during installation CMake will
#install all files whether they have changed or not. The default when
#this is not set is to install only files that have changed since the
#previous installation. In both cases all files are reported to
#indicate CMake knows they are up to date in the installed location.
#
#$ENV{name} : This is not an environment variable , but this is how
#you can access environment variables from cmake files. It returns
#the content of the environment variable with the given name (e.g.
#$ENV{PROGRAMFILES})
#
#DESTDIR : If this environment variable is set it will be prefixed to
#CMAKE_INSTALL_PREFIX in places where it is used to access files
#during installation. This allows the files to be installed in an
#intermediate directory tree without changing the final installation
#path name. Since the value of CMAKE_INSTALL_PREFIX may be included
#in installed files it is important to use DESTDIR rather than
#changing CMAKE_INSTALL_PREFIX when it is necessary to install to a
#intermediate staging directory.

#CMAKE_MAJOR_VERSION : major version number for CMake, e.g. the "2"
#in CMake 2.4.3
#
#CMAKE_MINOR_VERSION : minor version number for CMake, e.g. the "4"
#in CMake 2.4.3
#
#CMAKE_PATCH_VERSION : patch version number for CMake, e.g. the "3"
#in CMake 2.4.3
#
#CMAKE_TWEAK_VERSION : tweak version number for CMake, e.g. the "1"
#in CMake X.X.X.1. Releases use tweak < 20000000 and development
#versions use the date format CCYYMMDD for the tweak level.
#
#CMAKE_VERSION : The version number combined, eg.
#2.8.4.20110222-ged5ba for a Nightly build. or 2.8.4 for a Release
#build.
#
#CMAKE_GENERATOR : the generator specified on the commandline.
#
#BORLAND : is TRUE on Windows when using a Borland compiler
#
#WATCOM : is TRUE on Windows when using the Open Watcom compiler
#
#MSVC, MSVC_IDE, MSVC60, MSVC70, MSVC71, MSVC80,
#CMAKE_COMPILER_2005, MSVC90, MSVC10 (Visual Studio 2010) :
#Microsoft compiler
#
#CMAKE_C_COMPILER_ID : one of "Clang", "GNU", "Intel", or "MSVC".
#This works even if a compiler wrapper like ccache is used.
#
#CMAKE_CXX_COMPILER_ID : one of "Clang", "GNU", "Intel", or
#"MSVC". This works even if a compiler wrapper like ccache is used.

#CMAKE_SKIP_RULE_DEPENDENCY : set this to true if you don't want
#to rebuild the object files if the rules have changed, but not the
#actual source files or headers (e.g. if you changed the some
#compiler switches)
#
#CMAKE_SKIP_INSTALL_ALL_DEPENDENCY : since CMake 2.1 the install
#rule depends on all, i.e. everything will be built before
#installing. If you don't like this, set this one to true.
#
#CMAKE_INCLUDE_CURRENT_DIR : automatically add
#CMAKE_CURRENT_SOURCE_DIR and CMAKE_CURRENT_BINARY_DIR to the
#include directories in every processed CMakeLists.txt. It behaves as
#if you had used INCLUDE_DIRECTORIES in every CMakeLists.txt file or
#your project. The added directory paths are relative to the
#being-processed CMakeLists.txt, which is different in each
#directory. (See this
#thread
#for more details).
#
#CMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE : order the include
#directories so that directories which are in the source or build
#tree always come before directories outside the project.
#
#CMAKE_VERBOSE_MAKEFILE : set this to true if you are using
#makefiles and want to see the full compile and link commands instead
#of only the shortened ones
#
#CMAKE_SUPPRESS_REGENERATION : this will cause CMake to not put in
#the rules that re-run CMake. This might be useful if you want to use
#the generated build files on another machine.
#
#CMAKE_COLOR_MAKEFILE : create Makefiles with colored output
#(defaults to on)
#
#CMAKE_SKIP_PREPROCESSED_SOURCE_RULES : (since 2.4.4) if set to
#TRUE, the generated Makefiles will not contain rules for creating
#preprocessed files (foo.i)
#
#CMAKE_SKIP_ASSEMBLY_SOURCE_RULES : (since 2.4.4) if set to TRUE,
#the generated Makefiles will not contain rules for creating
#compiled, but not yet assembled files (foo.s)

#BUILD_SHARED_LIBS : if this is set to ON, then all libraries are
#built as shared libraries by default.
#SET(BUILD_SHARED_LIBS ON)
#
#CMAKE_BUILD_TYPE : A variable which controls the type of build
#when using a single-configuration generator like the Makefile
#generator. It is case-insensitive.
#########None (CMAKE_C_FLAGS or CMAKE_CXX_FLAGS used)
#########Debug (CMAKE_C_FLAGS_DEBUG or CMAKE_CXX_FLAGS_DEBUG)
#########Release (CMAKE_C_FLAGS_RELEASE or CMAKE_CXX_FLAGS_RELEASE)
#########RelWithDebInfo (CMAKE_C_FLAGS_RELWITHDEBINFO or
#########CMAKE_CXX_FLAGS_RELWITHDEBINFO
#########MinSizeRel (CMAKE_C_FLAGS_MINSIZEREL or
#########CMAKE_CXX_FLAGS_MINSIZEREL)

#CMAKE_CONFIGURATION_TYPES : When using a multi-configuration
#generator, such as the one for Visual Studio, this variable
#contains a list of the available configurations.

#CMAKE_CXX_COMPILER : the compiler used for C++ files. Normally it
#is detected and set during the CMake run, but you can override it at
#configuration time. Note! It can not be changed after the first
#cmake or ccmake run. See CMAKE_C_COMPILER above.
#
#CMAKE_CXX_FLAGS : the compiler flags for compiling C++ sources.
#Note you can also specify switches with ADD_COMPILE_OPTIONS().
#
#CMAKE_CXX_FLAGS_ : compiler flags for a specific
#configuration for C++ sources. Replace "" in the name with a
#specific build configuration name.
#
#CMAKE_SHARED_LINKER_FLAGS : additional compiler flags for
#building shared libraries

#CMAKE_EXECUTABLE_SUFFIX : Suffix of executables on the target
#platform.
#
#CMAKE_FIND_LIBRARY_PREFIXES : List of possible library prefixes
#used by find_library(). "lib" on UNIX systems.
#
#CMAKE_FIND_LIBRARY_SUFFIXES : List of possible library suffixes
#used by find_library(). ".a;.so" on UNIX systems. Note that it's
#possible to use this to control whether find_package() modules find
#shared or static libraries.
#
#CMAKE_<SHARED|STATIC>_LIBRARY_PREFIX : Prefix for shared or
#static libraries on this platform. Read-only.
#
#CMAKE_<SHARED|STATIC>_LIBRARY_SUFFIX : Suffix for shared or
#static libraries on this platform. Read-only.
#
#CMAKE__POSTFIX : Adds a custom "postfix" to static and
#shared libraries when in a certain build type. Example: Setting
#CMAKE_BUILD_TYPE=DEBUG and CMAKE_DEBUG_POSTFIX="_d"
#would turn mylib.lib into mylib_d.lib.

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

include(GoogleTest)
include(CMakePackageConfigHelpers)

# Install library for easy downstream inclusion  (move to bin the exe etc..)
include(GNUInstallDirs)

# Install runtime dependency 
include(InstallRequiredSystemLibraries)
#set(CMAKE_INSTALL_MFC_LIBRARIES TRUE)



#we set the specific option for each target
function(manage_target_options target_name)

	if(${${target_name}_BUILD_EXECUTABLE})
		add_executable(
			${target_name} 
			${${target_name}_SOURCES} 
			${${target_name}_PUBLIC_HEADERS}
			${${target_name}_PRIVATE_HEADERS}
		)
	elseif(${${target_name}_BUILD_HEADERS_ONLY})
		add_library(
			${target_name} 
			INTERFACE
			)
		target_sources(
			${target_name} 
			INTERFACE
			  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/${${target_name}_PUBLIC_HEADERS}>
			)
	elseif(${${target_name}_BUILD_STATIC_LIB})
		add_library(
			${target_name}
			STATIC
			${${target_name}_PUBLIC_HEADERS}
			${${target_name}_PRIVATE_HEADERS}
			${${target_name}_SOURCES}
		)
	else()
		add_library(
			${target_name}
			SHARED
			${${target_name}_PUBLIC_HEADERS}
			${${target_name}_PRIVATE_HEADERS}
			${${target_name}_SOURCES}
		)
		## Export all symbols when building a shared library
		#if(${PROJECT_NAME}_BUILD_SHARED_LIBS)
		#	set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS OFF)
		#	set(CMAKE_CXX_VISIBILITY_PRESET hidden)
		#	set(CMAKE_VISIBILITY_INLINES_HIDDEN 1)
		#endif()
	endif()
	
	verbose_message("Added source file ${${target_name}_SOURCES} and ${${target_name}_PUBLIC_HEADERS} for ${target_name}")
	
	#  target_compile_definitions(${PROJECT_NAME} PRIVATE   NEWLIB_THREAD_SAFE  )  #No need for  the -D
	#  target_compile_options(${PROJECT_NAME} PRIVATE -O0 -g -fprofile-arcs -ftest-coverage)
	#  target_compile_features()
	#  target_link_options(${PROJECT_NAME} PRIVATE -fprofile-arcs -ftest-coverage)
	
	#set_target_properties(
	#	${target_name} 
	#	PROPERTIES
	#		VS_DEBUGGER_WORKING_DIRECTORY "$(TargetDir)"
	#)

	if(${${target_name}_BUILD_HEADERS_ONLY})
		target_compile_features(${target_name} INTERFACE cxx_std_11)
		target_include_directories(
		${target_name}
		INTERFACE 
		 $<BUILD_INTERFACE:${${target_name}_SOURCE_DIR}>
	)
	else()
		target_compile_features(${target_name} PUBLIC cxx_std_11)
		target_include_directories(
		${target_name}
		PUBLIC 
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>  
	)
	endif()
	
	if(${${target_name}_INSTALL_HEADER} ) 
		set_target_properties( ${target_name} PROPERTIES PUBLIC_HEADER ${${target_name}_PUBLIC_HEADERS} )
	endif()
	
	
	verbose_message("Finished set include_directories for ${target_name}")

	if(${${target_name}_BUILD_HEADERS_ONLY})
		target_link_libraries(${target_name} INTERFACE 
			${${target_name}_LINKER_DEPENDECY}
		)
	else()
		target_link_libraries(${target_name} PUBLIC 
			${${target_name}_LINKER_DEPENDECY}
		)
					#Compile option	
		target_link_libraries(${target_name} PRIVATE
			$<BUILD_INTERFACE:project_global_options>
		)

	endif()
	verbose_message("Finished set library dependency for ${target_name}")
	
	
	if( NOT ${${target_name}_BUILD_HEADERS_ONLY})
		
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
		
		target_link_libraries(${target_name} PRIVATE  
			$<BUILD_INTERFACE:project_global_warnings>
		)
		verbose_message("Finished set project warning for ${target_name}")
	endif()
	
	#if(ENABLE_CONAN)
	#	target_include_directories(${target_name} PUBLIC ${CONAN_INCLUDE_DIRS} ) 
	#endif()
		
	if(${${target_name}_ENABLE_UNIT_TESTING} AND ENABLE_CONAN)
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
			${CMAKE_INSTALL_INCLUDEDIR}
		PUBLIC_HEADER DESTINATION
			${CMAKE_INSTALL_INCLUDEDIR}
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