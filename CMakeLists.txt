cmake_minimum_required(VERSION 3.12)

if(${CMAKE_VERSION} VERSION_LESS 3.12)
    cmake_policy(VERSION ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION})
endif()

project(Batches   VERSION 0.1.0
				  DESCRIPTION  "Modern CPPSeed"
                  LANGUAGES    CXX
		)
		
		
#First we need to set the utils function for cmake
include(CMake/CompilerWarnings.cmake)
include(CMake/GlobalCompileOption.cmake)
include(CMake/Utils.cmake)

#Sanity checks 
# Prevent building in the source directory 
if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(FATAL_ERROR "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there.\n")
endif()

#Then we load the global option
include(CMake/GlobalOptions.cmake)

	
#Load ConanConfiguration
include(CMake/ConanConfig.cmake)


add_subdirectory(Libraries)
add_subdirectory(Batches)

#If build correctly, copy the resources forlder to the binary dir 
#add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
#                   COMMAND ${CMAKE_COMMAND} -E copy_directory
#                       ${CMAKE_SOURCE_DIR}/resources $<TARGET_FILE_DIR:${PROJECT_NAME}>/resources
#					COMMAND ${CMAKE_COMMAND} -E copy_directory
#                       ${CMAKE_SOURCE_DIR}/resources ${CMAKE_BINARY_DIR}/resources )




# Install library for easy downstream inclusion  (move to bin the exe etc..)
include(GNUInstallDirs)







#----------------END OF FILE-----------------#


####UNUSED CODE BUT I KEEP IT 
# Identify and link with the specific "packages" the project uses
#find_package(GLEW REQUIRED)
#find_package(OpenGL REQUIRED)
#find_package(package_name package_version REQUIRED package_type [other_options])
#target_link_libraries(
#  ${PROJECT_NAME}
#  PUBLIC
#    dependency1 ...
#  PRIVATE
#    dependency2 ...
#    ${PROJECT_NAME}_PROJECT_OPTIONS        
#    ${PROJECT_NAME}_PROJECT_WARNINGS        
#)


##Add Extrenal project exemple :   
#SET(SFML_RELEASE 2.5.1)
#ExternalProject_Add(sfml_ext
#	URL https://www.sfml-dev.org/files/SFML-${SFML_RELEASE}-sources.zip
#	URL_HASH "SHA256=bf1e0643acb92369b24572b703473af60bac82caf5af61e77c063b779471bb7f"
#	UPDATE_COMMAND ""
#	DOWNLOAD_DIR ${CMAKE_BINARY_DIR}
#	SOURCE_DIR ${CMAKE_BINARY_DIR}/SFML-${SFML_RELEASE}
#	BUILD_IN_SOURCE 0
#	
#	CMAKE_ARGS
#		${SDL_CMAKE_BUILD_OPTS}
#		-DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}/deps/${CMAKE_BUILD_TYPE}
#		-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
#		-DCMAKE_C_FLAGS=${FLAGS_FOR_DYNAMIC_LINK} ${EXTERNAL_C_FLAGS}
#	)
#	
#add_library(sfml STATIC IMPORTED GLOBAL)
#add_dependencies(sfml sfml_ext)
#	
#MESSAGE(STATUS "SFML Installing to: ${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE}")
#SET(SFML_INCLUDE_DIR ${CMAKE_INSTALL_PREFIX}/deps/${CMAKE_BUILD_TYPE}/include)
#SET(SFML_LIBRARY_DIR ${CMAKE_INSTALL_PREFIX}/deps/${CMAKE_BUILD_TYPE}/lib)
#
#message("INCLUDES_SFML : ${SFML_INCLUDE_DIR}")
#message("LIBS_SFML : ${SFML_LIBRARY_DIR}")
#
#set(SFML_GRAPHIC_BASE_NAME "sfml-graphics")
#set(SFML_WINDOW_BASE_NAME "sfml-window")
#set(SFML_SYSTEM_BASE_NAME "sfml-system")
#IF("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
#	IF(WIN32)
#		 set(ARCH_PREFIX "${CMAKE_STATIC_LIBRARY_PREFIX}" )
#		 set(ARCH_POSTFIX "-d${CMAKE_STATIC_LIBRARY_SUFFIX}")
#	ELSEIF(APPLE)
#		 set(ARCH_POSTFIX "")
#	 ELSE()
#		 set(ARCH_PREFIX "" )
#		 set(ARCH_POSTFIX "-d")
#	ENDIF()
#ELSE()
#	IF(WIN32)
#		 set(ARCH_POSTFIX "")
#	ELSEIF(APPLE)
#		 set(ARCH_POSTFIX "")
#	ELSE()
#		 set(ARCH_POSTFIX "")
#	ENDIF()
#ENDIF()
#set(SFML_GRAPHIC_NAME
#"${ARCH_PREFIX}${SFML_GRAPHIC_BASE_NAME}${ARCH_POSTFIX}")
#set(SFML_WINDOW_NAME
#"${ARCH_PREFIX}${SFML_WINDOW_BASE_NAME}${ARCH_POSTFIX}")
#set(SFML_SYSTEM_NAME
#"${ARCH_PREFIX}${SFML_SYSTEM_BASE_NAME}${ARCH_POSTFIX}")
#
#set(SFML_LIBRARIES "${SFML_GRAPHIC_NAME};${SFML_WINDOW_NAME};${SFML_SYSTEM_NAME}" )
#message("${SFML_LIBRARIES}")
#
#add_dependencies(RLTestBin sfml)  #don't forget the targetLinkLibrary
#
#
#
###END!!!! AddExternalExemple 