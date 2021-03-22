#include "ofHotLoad.h"


// We specify that this function is going to be exported. Extern "C" is for name mangling
extern "C" __declspec(dllexport) LOADED_FUNCTION(loadedFunction)
{
	std::cout << "HOT LOAD " << std::endl;
}