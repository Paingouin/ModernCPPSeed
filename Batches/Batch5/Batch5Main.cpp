#include "ofHotLoad.h"
#include <Windows.h>

struct win32_struct
{
	HMODULE codeDLL;
	FILETIME lastDLLwriteTime;
	
	loaded_function* loadedFunction;
	
	bool isValid;
};

FILETIME getLastWriteTime(const char* fileName)
{
	FILETIME lastWriteTime = {};
	WIN32_FILE_ATTRIBUTE_DATA data;
	if (GetFileAttributesEx(fileName, GetFileExInfoStandard, &data))
		lastWriteTime = data.ftLastWriteTime;

	return lastWriteTime;
}

win32_struct loadCode(const char* sourceDLLname, const char* tempDLLname,const char* lockFileName)
{
	win32_struct result = {};

	WIN32_FILE_ATTRIBUTE_DATA ignored;
	if (!GetFileAttributesEx(lockFileName, GetFileExInfoStandard, &ignored))
	{
		result.lastDLLwriteTime = getLastWriteTime(sourceDLLname);

		CopyFile(sourceDLLname, tempDLLname, FALSE);
		result.codeDLL = LoadLibraryA(tempDLLname);
		if (result.codeDLL)
		{
			result.loadedFunction = (loaded_function*)GetProcAddress(result.codeDLL, "loadedFunction");
			result.isValid = result.loadedFunction;
		}
	}

	if (!result.isValid)
	{
		result.loadedFunction = loaded_functionStub;
	}

	return result;
}

void unloadCode(win32_struct* code)
{
	if (code->codeDLL)
	{
		FreeLibrary(code->codeDLL);
		code->codeDLL = 0;
	}

	code->isValid = false;
	code->loadedFunction = 0;
}

int main(int argc, char* argv[])
{
	
	// Before  loop (platform layer)
	win32_struct code = loadCode("./ofHotLoad.dll", "./ofHotLoad_temp.dll", "./LOCK.TMP");

	// Inside the loop (platform layer)

	while(true)
	{
		FILETIME newDLLwriteTime = getLastWriteTime("./ofHotLoad.dll");
		bool isExeReloaded = false;

		// Check if the name of the DLL has changed. Since we create a unique DLL name each time, this event
		// indicates that a code reloading needs to happen
		bool doesExeNeedReloading = (CompareFileTime(&newDLLwriteTime, &code.lastDLLwriteTime) != 0);
		if (doesExeNeedReloading)
		{
			// If the code is multithreaded and a work queue is implemented, complete all
			// the task now because the callbacks may point to invalid memory after the reloading
			//...

			// If the debug system is designed to record events along the codebase, now it's the
			// time to stop it
			//...

			unloadCode(&code);
	        code = loadCode("./ofHotLoad.dll", "./ofHotLoad_temp.dll", "./LOCK.TMP");
			isExeReloaded = true;
		}

		code.loadedFunction();
	}
	
	return 0;
}