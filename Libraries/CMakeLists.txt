add_subdirectory(lowLevel)
add_subdirectory(libExecutable)

if(WIN32)
	add_subdirectory(libofHotload)
endif()