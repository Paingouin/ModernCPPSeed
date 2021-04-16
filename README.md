# ModernCPPSeed
<!-- [![MacOS](https://github.com/Paingouin/ModernCPPSeed/workflows/MacOS/badge.svg)](https://github.com/Paingouin/ModernCPPSeed/actions) -->
[![Windows](https://github.com/Paingouin/ModernCPPSeed/workflows/Windows/badge.svg)](https://github.com/Paingouin/ModernCPPSeed/actions)
[![Ubuntu](https://github.com/Paingouin/ModernCPPSeed/workflows/Ubuntu/badge.svg)](https://github.com/Paingouin/ModernCPPSeed/actions)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/Paingouin/ModernCPPSeed)](https://github.com/Paingouin/ModernCPPSeed/releases)
*** DOCUMENTATION STILL IN PROGRESS ***
## Informations
This project is used as a starting block to have a nice coexisting cmake environmnent. Without having to learn a lot of CMake stuff.

We will lose a little control about what we do , in exchange of a simpler and *prettier* environment to use.

I will explain everything you need to know, step by step, to have a cozy space to work.

The principle is that you only have to add your folder with your .cpp/.h files, choose of you want an executable/a lib, your dependencies and that's it. 

Here, what I call a batches is an executable, and a library is a static or dynamic library used by the batches.

## How CMake works
Cmake is a build system generator. It is used to create all the things  the compilers/linkers etc.. will need to create the wanted binaries.

When invoking CMake, it will read the *CMakeLists.txt* files in our project, set all the settings/paths he will give to our tools and voilà.

To use cmake , you will need to have one compilator toolkit installed on the plateform you will run cmake and build your programm. (MSVC or GNU GCC for exemple)

Cmake is generally used by command line in a separete directory 

But I provided in the folder Tools/Builders, some script who will invoke CMake directly. (Descripted below)

As far as I'm concerned , I like to use this kind of command in the root folder of this project

```
cd ../..
mkdir Build
cd Build

cmake .. -G"Visual Studio 15 2017" -Ax64  -DCMAKE_INSTALL_PREFIX=../install
```

Will create  a "Build" folder inside the root folder of this project.
We then go inside this project and lanch cmake using these parameter :
* We want to use Visual studio 15 (2017)
* We use an x64 architecture
* We will install all the binaries in a folder named "install" at the root direcory of the project (more on that later)

You can now use also cmake to invoke your compilator too and build your binaries directly.
After doing the steps before you use this command line : 
```
cmake --build . --config Release -j 4
```

Will invoke your compiler to build the binaries at Release mode using 4 thread if possible.

## Structure of the project 
---
Now that we know how to launch cmake , I will explain how to configure it, without all the schlimblik 

First, at the root of the project, you have a CMakeList.txt, this one is used : 
* name our project
* read the Global Options
* launch Conan
* read the others CmakeLists.txt (the one of our batches/libraries)

```
ModernCPPSeed
╚╦═ Batches    
 ║  ╠═ Batch_1
 ║  ║  ╠═  cpp and .h files
 ║  ║  ╚═  CMakeLists.txt --where  you configure your exe
 ║  ║
 ║  ╠═ Batch_2
 ║  ║  ╠═  cpp and .h files
 ║  ║  ╚═  CMakeLists.txt
 ║  ╚═  CMakeLists.txt --where you add the batches you want to add, with add_subdirectory
 ║
 ╠═ Libraries
 ║  ╠═ Library_1
 ║  ║  ╠═  cpp and .h files
 ║  ║  ╚═  CMakeLists.txt --where  you configure your lib
 ║  ║
 ║  ╠═ Library_2
 ║  ║  ╠═  cpp and .h files
 ║  ║  ╚═  CMakeLists.txt --where  you configure your lib
 ║  ╚═  CMakeLists.txt --where you add the libraries you want to add, with add_subdirectory
 ║
 ╠═ CMake
 ║  ╠═ GlobalOption.cmake --where you configure the global option of your programm
 ║  ╠═ Gonan.cmake --where you configure conan
 ║  ╚═ GlobalCompileOption.cmake 
 ║
 ╠═ Tools
 ║   ╚═ Contain tools to help  generate/build and install the binaries
 ║
 ╚═ CMakeLists.txt --The main CMakeLists.txt (the one read in first by Cmake) 
 
```




The binaires will be put in a Build\bin\SYSTEM_NAME\BUILD_TYPE and the statc lib in Build\lib\SYSTEM_NAME\BUILD_TYPE.


## Global Options

Global option can be found in Cmake\GlobalOptions.cmake

These impact all the batches/library.

| Options       |    Description        | Value possible  |
| ------------- |-------------| -----|
|CMAKE_SKIP_BUILD_RPATH |  | TRUE or FALSE, default TRUE |
|CMAKE_INSTALL_RPATH_USE_LINK_PATH |  | TRUE or FALSE , default FALSE|
|WARNINGS_AS_ERRORS | Enable the warning as error for all project | ON or OFF , default OFF|
|ENABLE_CONAN | Enable the warning as error for all project. | ON or OFF , default ON|
|ENABLE_CLANG_TIDY | Enable static analysis with Clang-Tidy. | ON or OFF , default OFF|
|ENABLE_CODE_COVERAGE | Enable code coverage through GCC (gcov) or cpplint or --coverage| ON or OFF , default OFF|
|ENABLE_DOXYGEN | Enable Doxygen documentation builds of source.| ON or OFF , default OFF|
|ENABLE_INCLUDE_WHAT_YOU_USE | Enable Include what you use on a global scope.| ON or OFF , default OFF|
|ENABLE_LINK_WHAT_YOU_USE | Enable Link what you use on a global scope.| ON or OFF , default OFF|
|CMAKE_EXPORT_COMPILE_COMMANDS |  Generate compile_commands.json for clang based tools.| ON or OFF , default ON|
|VERBOSE_OUTPUT|Enable verbose output when cmake is running, allowing for a better understanding of each step taken.| ON or OFF, default ON|
|ENABLE_CCACHE|Enable the usage of CCache, in order to speed up build times.| ON or OFF, default ON|
|ENABLE_LTO|Enable the usage of CCache, in order to speed up build times.| ON or OFF, default OFF|







## Global compile Options

There's a Cmake\GlobalCompileOption.cmake file where you can add all the options that will be use by all the batches and libraries.



## Batches and library option.
This is what you have to configure the most 

Add a cmakeList in the folder Batches or Libraries

Modify the CmakeList.txt

you habe to set theses option in terms of you want to use.

First you want to name your executable/library/project.
```cmake
project (BatchNAME CXX)
```
Replace "BatchName" with what you want to use.

You then want to add the headers of your programm  :
```cmake
set( ${PROJECT_NAME}_PUBLIC_HEADERS
		Batch4.h
	)
```
You can put them in an other folder like this :
```cmake
set( ${PROJECT_NAME}_PUBLIC_HEADERS
		Include/Batch4.h
	)
```

You can also add them as private header like this : 
```cmake
set( ${PROJECT_NAME}_PRIVATE_HEADERS
		Batch4.h
	)
```

Now, you have to choose if you want a executable , a static lib or a dynamic library.
You can add one of these lines :
* for the executable 
```cmake
set(${PROJECT_NAME}_BUILD_EXECUTABLE ON )
```
* for a static lib 
```cmake
set(${PROJECT_NAME}_BUILD_STATIC_LIB ON )
```
* for a dynamic lib
```cmake
set(${PROJECT_NAME}_BUILD_STATIC_LIB OFF )
```


If you want to add compilation/linker options and definition , you can add your own : 
```cmake
if(MSVC)
	set(${PROJECT_NAME}_COMPILER_DEFINITION "")
	set(${PROJECT_NAME}_COMPILER_DEFINITION_DEBUG "")
	set(${PROJECT_NAME}_COMPILER_DEFINITION_RELEASE "")
	set(${PROJECT_NAME}_COMPILER_OPTIONS "")
	set(${PROJECT_NAME}_COMPILER_OPTIONS_DEBUG "")
	set(${PROJECT_NAME}_COMPILER_OPTIONS_RELEASE "")
	set(${PROJECT_NAME}_LINKER_OPTIONS "")
	set(${PROJECT_NAME}_LINKER_OPTIONS_DEBUG "")
	set(${PROJECT_NAME}_LINKER_OPTIONS_RELEASE "")
elseif(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang" AND NOT ${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")

elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")

endif()
```


If your library/batch is dependent from anither, you can add the dependency like this :

```cmake
set(${PROJECT_NAME}_LINKER_DEPENDECY CONAN_PKG::glm libCamera )
```
Here , in the exemple, my lib will be dependent of the glm Conan package and from the libCamera .

at the end , add the function that will manage all the options : 
```cmake
manage_target_options(${PROJECT_NAME})
```





## Note
I refuse to support Apple anymore. Their policies are more and more aggresive toward devellopers. I canno't spend my time to support the "Apple only rendering pipeline, Apple only cu architecture etc"... 
A blog from a fellow roguelikedev who made a good summarry: https://www.gridsagegames.com/blog/2019/09/sorry-mac-users-apple-doesnt-care-about-us-devs/

## Build Tools
Inside Tools/Builders

## Hot-Loading (Windows Only for the moment)
To test the hot-loading, compile the batch-hot-loading, launch it manually (in the folder build/bin/Debug) and let it run.
Open the project ofHotLoad
Change the content of the method loadedFunction and build the project.
The changes should appear.
