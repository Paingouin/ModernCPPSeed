project (ofInput CXX)

set( sources
		ofInput.cpp
	)
set( headers
		ofInput.h
	)
	
option(${PROJECT_NAME}_BUILD_EXECUTABLE  "If we want an execultable" OFF)
option(${PROJECT_NAME}_BUILD_HEADERS_ONLY  "If we want an header only" OFF)
option(${PROJECT_NAME}_BUILD_STATIC_LIB "If we want a static lib" ON)

option(${PROJECT_NAME}_ENABLE_UNIT_TESTING "If we have a test unit in a folder named 'test'" OFF)


manage_targetOptions(${PROJECT_NAME} ${headers} ${sources})

#you can still now do things like :
#target_link_libraries(${PROJECT_NAME} PUBLIC CONAN_PKG::Thot)
