
#Option are set in this file by default. You can change it with the -D argument in the cmake command line

#Compile
option(WARNINGS_AS_ERRORS "Enable the warning as error for all project" OFF)

#package
option(ENABLE_CONAN "Enable the Conan package manager for all project." ON)
option(ENABLE_VCPKG "Enable the Conan package manager for all project." OFF)

#unit test
option(ENABLE_UNIT_TESTING "Enable unit tests for all projects (from the `test` subfolder)." ON)

option(USE_GTEST "Use GTEST  for creating unit tests." ON)
#option(${PROJECT_NAME}_USE_GOOGLE_MOCK "Use the GoogleMock project for extending the unit tests." OFF)
#option(${PROJECT_NAME}_USE_CATCH2 "Use the Catch2 project for creating unit tests." OFF)

# Static analyzers
option(ENABLE_CLANG_TIDY "Enable static analysis with Clang-Tidy." OFF)
option(ENABLE_CPPCHECK "Enable static analysis with Cppcheck." OFF)

#Code Coverage
option(ENABLE_CODE_COVERAGE "Enable code coverage through GCC." OFF)

#Doxygen
option(ENABLE_DOXYGEN "Enable Doxygen documentation builds of source." OFF)

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


# Set the output path for bin and lib
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY	${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY	${CMAKE_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY	${CMAKE_BINARY_DIR}/lib)
#set(VS_DEBUGGER_WORKING_DIRECTORY   ${CMAKE_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE})
#set(CMAKE_INSTALL_LIBDIR 			lib)
#set(CMAKE_INSTALL_BINDIR			bin)
#set(CMAKE_INSTALL_INCLUDEDIR		include)
