if(ENABLE_CONAN)

  # Setup Conan requires and options here:
    set(CONAN_REQUIRES "")
	set(CONAN_OPTIONS "")
	
	set(CONAN_FILE "CMake/ConanConfig/conanfile.py")

  # If `conan.cmake` (from https://github.com/conan-io/cmake-conan) does not exist, download it.
  #
  #if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
  # message(
  #    STATUS
  #      "Downloading conan.cmake from https://github.com/conan-io/cmake-conan..."
  ##  )
   # file(DOWNLOAD "https://github.com/conan-io/cmake-conan/raw/v0.15/conan.cmake"
   #   "${CMAKE_BINARY_DIR}/conan.cmake"
   # )
   # message(STATUS "Cmake-Conan downloaded succesfully.")
  #endif()

  include(${CMAKE_SOURCE_DIR}/CMake/conan.cmake)

  #conan_add_remote(NAME bincrafters
  #    URL
  #        https://api.bintray.com/conan/bincrafters/public-conan
	#  INDEX 
	#	  0
  #)

  verbose_message("Call Conan with ${CONAN_FILE}")
  
  conan_cmake_run(
    REQUIRES
      ${CONAN_REQUIRES}
	CONANFILE
	  ${CONAN_FILE}
    OPTIONS
      ${CONAN_OPTIONS}
	BASIC_SETUP
	SKIP_RPATHS
	CMAKE_TARGETS
    BUILD
      missing
  )
  

endif()


function(conan_move_shared_libs )

	

endfunction()
