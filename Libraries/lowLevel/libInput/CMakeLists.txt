project (ofInput CXX)

set( sources
		ofInput.cpp
	)
set( headers
		ofInput.h
	)
	
set(${PROJECT_NAME}_BUILD_STATIC_LIB ON)

set(${PROJECT_NAME}_ENABLE_UNIT_TESTING OFF)


#if not set, each of these will use the globals option in /CMake/GlobalOptions


set(${PROJECT_NAME}_LINKER_DEPENDECY "")


manage_targetOptions(${PROJECT_NAME} ${headers} ${sources})

#you can still now do things like :
#target_link_libraries(${PROJECT_NAME} PUBLIC CONAN_PKG::Thot)
