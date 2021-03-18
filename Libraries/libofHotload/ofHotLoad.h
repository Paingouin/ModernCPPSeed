// THANKS HANDMADE HERO !
// First we create a macro that simply defines a function, and then we define a function pointer. 
// This allows to eventually introduce a "stub" version of the function, for example in order to handle cases of failed initialization
#pragma once
#include <iostream>

#define LOADED_FUNCTION(name) void name()
typedef LOADED_FUNCTION(loaded_function);

// This function is used in case the GetProcAdress does not work
LOADED_FUNCTION(loaded_functionStub)
{
	std::cout << "There was a problem , stub is loaded" << std::endl;
}

