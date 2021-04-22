#Option are set in this file by default. You can change it with the -D argument in the cmake command line


SET(CMAKE_SKIP_BUILD_RPATH TRUE)
SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH FALSE)

#Compile
option(WARNINGS_AS_ERRORS "Enable the warning as error for all project" OFF)

#package
option(ENABLE_CONAN "Enable the Conan package manager for all project." OFF)
#option(ENABLE_VCPKG "Enable the Conan package manager for all project." OFF)

#unit test : for the moment, it's per project
#option(ENABLE_UNIT_TESTING "Enable unit tests for all projects (from the `test` subfolder)." OFF)

#option(USE_GTEST "Use GTEST  for creating unit tests." ON)
#option(${PROJECT_NAME}_USE_GOOGLE_MOCK "Use the GoogleMock project for extending the unit tests." OFF)
#option(${PROJECT_NAME}_USE_CATCH2 "Use the Catch2 project for creating unit tests." OFF)

# Static analyzers
option(ENABLE_CLANG_TIDY "Enable static analysis with Clang-Tidy." OFF)
if(ENABLE_CLANG_TIDY)
  find_program(CLANGTIDY clang-tidy)
  if(CLANGTIDY)
    set(CMAKE_CXX_CLANG_TIDY ${CLANGTIDY} -extra-arg=-Wno-unknown-warning-option)
    message("Clang-Tidy finished setting up.")
  else()
    message(SEND_ERROR "Clang-Tidy requested but executable not found.")
  endif()
endif()

#TODO(AddCLangfOrmat)
#
#
#


option(ENABLE_CPPCHECK "Enable static analysis with Cppcheck." OFF)
if(ENABLE_CPPCHECK)
  find_program(CPPCHECK cppcheck)
  if(CPPCHECK)
    set(CMAKE_CXX_CPPCHECK ${CPPCHECK} --suppress=missingInclude --enable=all
                           --inline-suppr --inconclusive -i ${CMAKE_SOURCE_DIR}/src)
    message("Cppcheck finished setting up.")
  else()
    message(SEND_ERROR "Cppcheck requested but executable not found.")
  endif()
endif()


#Code Coverage
option(ENABLE_CODE_COVERAGE "Enable code coverage through GCC." OFF)
# target_compile_options(project_options INTERFACE --coverage -O0 -g)
# target_link_libraries(project_options INTERFACE --coverage)
# Setup code coverage if enabled
#if (ENABLE_CODE_COVERAGE)
#  target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC -O0 -g -fprofile-arcs -ftest-coverage)
#  target_link_options(${CMAKE_PROJECT_NAME} PUBLIC -fprofile-arcs -ftest-coverage)
#  verbose_message("Code coverage is enabled and provided with GCC.")
#find_program(GCOV "gcov" DOC "Coverage tool")
  #message(STATUS ${GCOV})
  #find_program(GCOVR "gcovr" DOC "Coverate report tool")
#
  #set(coverage_report_dir "${CMAKE_BINARY_DIR}/coverage")
  #file(MAKE_DIRECTORY ${coverage_report_dir})	
#endif()

#set(CMAKE_CXX_CPPLINT "cpplint")
#set(

#Doxygen
option(ENABLE_DOXYGEN "Enable Doxygen documentation builds of source." OFF)
if(ENABLE_DOXYGEN)
    set(DOXYGEN_CALLER_GRAPH YES)
    set(DOXYGEN_CALL_GRAPH YES)
    set(DOXYGEN_EXTRACT_ALL YES)
    set(DOXYGEN_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/docs)
    
    find_package(Doxygen REQUIRED dot)
    doxygen_add_docs(doxygen-docs ${PROJECT_SOURCE_DIR})

    verbose_message("Doxygen has been setup and documentation is now available.")
endif()

#IWYU
option(ENABLE_INCLUDE_WHAT_YOU_USE "Enable Include what you use on a global scope." OFF)
if(ENABLE_INCLUDE_WHAT_YOU_USE)
	find_program(IWYU_PATH NAMES include-what-you-use iwyu)
	if(NOT IWYU_PATH)
		message(FATAL_ERROR "Could not find the program include-what-you-use")
	endif()
	set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE ${IWYU_PATH})
    verbose_message("IWYU has been setup.")
endif()

#LWYU
option(ENABLE_LINK_WHAT_YOU_USE "Enable Link what you use on a global scope." OFF)
if(ENABLE_LINK_WHAT_YOU_USE)
	find_program(LWYU_PATH NAMES link-what-you-use lwyu)
	if(NOT LWYU_PATH)
		message(FATAL_ERROR "Could not find the program link-what-you-use")
	endif()
	set(CMAKE_CXX_LINK_WHAT_YOU_USE ${LWYU_PATH})

    verbose_message("LWYU has been setup.")
endif()


# Generate compile_commands.json for clang based tools
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

#DEBUG
option(VERBOSE_OUTPUT "Enable verbose output, allowing for a better understanding of each step taken." ON)

#ccache
option(ENABLE_CCACHE "Enable the usage of CCache, in order to speed up build times." ON)
find_program(CCACHE_FOUND ccache)
if(CCACHE_FOUND)
    verbose_message("Found CCache so we use it !")
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ccache)
endif()

##LTO
option(ENABLE_LTO "Enable Interprocedural Optimization, aka Link Time Optimization (LTO)." OFF)
if(ENABLE_LTO)
	include(CheckIPOSupported)
	check_ipo_supported(RESULT result OUTPUT output)
	if(result)
		set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
	else()
		message(SEND_ERROR "IPO is not supported: ${output}.")
	endif()
endif()

##PARALLEL Compilation
#option(ENABLE_PARALLEL_COMPILATION "Enable the parallel compilation" ON)
#cmake --build --parrallel
#cmake --build -j
	
# Set the output path for bin and lib

message("Cmake build type : ${CMAKE_BUILD_TYPE}")

if(MSVC)

	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY	${CMAKE_BINARY_DIR}/bin/${CMAKE_SYSTEM_NAME})
	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY	${CMAKE_BINARY_DIR}/lib/${CMAKE_SYSTEM_NAME})
	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY	${CMAKE_BINARY_DIR}/lib/${CMAKE_SYSTEM_NAME})

	message("CMAKE_RUNTIME_OUTPUT_DIRECTORY : ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}   ${CMAKE_SYSTEM_NAME}")
else()
	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY	${CMAKE_BINARY_DIR}/bin/${CMAKE_SYSTEM_NAME}/${CMAKE_BUILD_TYPE}/)
	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY	${CMAKE_BINARY_DIR}/bin/${CMAKE_SYSTEM_NAME}/${CMAKE_BUILD_TYPE}/) #we want the dynamic .so to be in the same directory as the executables
	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY	${CMAKE_BINARY_DIR}/lib/${CMAKE_SYSTEM_NAME}/${CMAKE_BUILD_TYPE}/)
endif()


#set(VS_DEBUGGER_WORKING_DIRECTORY   ${CMAKE_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE})
#set(CMAKE_INSTALL_LIBDIR 			lib)
#set(CMAKE_INSTALL_BINDIR			bin)
#set(CMAKE_INSTALL_INCLUDEDIR		include)

##if (${FORCE_COLORED_OUTPUT})
#    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
#        target_compile_options (project_options INTERFACE -fdiagnostics-color=always)
#    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
#        target_compile_options (project_options INTERFACE -fcolor-diagnostics)
#    endif ()
#endif ()
