project (ofFile CXX)

set( sources
		ofFile.cpp
	)
set( headers
		ofFile.h
	)
	

set(${PROJECT_NAME}_BUILD_STATIC_LIB ON )

set(${PROJECT_NAME}_ENABLE_UNIT_TESTING OFF)

manage_targetOptions(${PROJECT_NAME} ${headers} ${sources})

#you can still now do things like :
#target_link_libraries(${PROJECT_NAME}  CONAN_PKG::Thot)
