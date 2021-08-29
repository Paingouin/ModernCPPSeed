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

The principle is that you only have to add your folder with your .cpp/.h files, choose if you want an executable/a lib, your dependencies and that's it. 

NOTE : a library is either a static or dynamic library used by the executables.

## How CMake works
You can skip this section if you know how to invoke cmake and your compiler.

Cmake is a build system generator. It is used to create all the things the compilers/linkers etc.. will need to create the wanted binaries.

When invoking CMake, it will read the *CMakeLists.txt* files in our project, set all the settings/paths he will give to our tools and voilà.

To use cmake , you will need to have one compiler toolkit installed on the plateform you will run cmake and build your programm. (MSVC or Make + GNU GCC for exemple)

Cmake is generally used by command line, but I will show the generic way to use it.

I provided in the folder Tools/Builders, some script who will invoke CMake directly. (Descripted below)

As far as I'm concerned , I like to use this kind of command in the root folder of this project.

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
You can also use your IDE or the compiler tools directly to build your binaries.

## Structure of the project 
Now that we know how to launch cmake , I will explain how to configure it, without all the schlimblik 

First, at the root of the project, you have a CMakeList.txt, this one is used to : 
* name our project
* read the Global Options
* launch Conan
* read the others CmakeLists.txt (the one of our Executables/libraries)
  * First it will read the CmakeList.txt inside the folder Libraries
  * Then it will read the CmakeList.txt inside the folder Executables


Here's a schema of the structure of the model : 

```
ModernCPPSeed
║
╚╦═ Executables    
 ║  ╠═ Executable_1
 ║  ║  ╠═  .cpp and .h files
 ║  ║  ╚═  CMakeLists.txt --where  you configure your exe
 ║  ║
 ║  ╠═ Executable_2
 ║  ║  ╠═  .cpp and .h files
 ║  ║  ╚═  CMakeLists.txt
 ║  ║
 ║  ╚═  CMakeLists.txt --where you add the Executables you want to add, with add_subdirectory
 ║
 ╠═ Libraries
 ║  ╠═ Library_1
 ║  ║  ╠═  .cpp and .h files
 ║  ║  ╚═  CMakeLists.txt --where  you configure your lib
 ║  ║
 ║  ╠═ Library_2
 ║  ║  ╠═  .cpp and .h files
 ║  ║  ╚═  CMakeLists.txt --where  you configure your lib
 ║  ║
 ║  ╚═  CMakeLists.txt --where you add the libraries you want to add, with add_subdirectory
 ║
 ╠═ CMake
 ║  ╠═ GlobalOption.cmake --where you configure the global option of your programm
 ║  ╠═ Gonan.cmake --where you configure conan
 ║  ╠═ GlobalCompileOption.cmake
 ║  ║
 ║  ╚═ Conan
 ║     ╚═ conanfile.py --contain the information conan need to retrive the ext.libs 
 ║
 ╠═ Tools
 ║   ╚═ Contain tools to help  generate/build and install the binaries
 ║
 ╚═ CMakeLists.txt --The main CMakeLists.txt (the one read in first by Cmake) 
 
```
In the folder Executable, I to put my executables , each Executable represent an executable binary (but nothing prevent you to make libraries into these folder)
In the folder Libraries, I prefer to put all my self-made Libraries, and libraries who I have the source file like headers only libraries. (nothing prevent you to make executable inside this folder)



The binaires will be put in a Build\bin\SYSTEM_NAME\BUILD_TYPE and the statc lib in Build\lib\SYSTEM_NAME\BUILD_TYPE.


## Global Options

Global option can be found in Cmake\GlobalOptions.cmake

These impact all the Executables/library.

| Options       |    Description        | Value possible  |
| ------------- |-------------| -----|
|CMAKE_SKIP_BUILD_RPATH | The build process will not change the RPATH of the executable | TRUE or FALSE, default TRUE |
|CMAKE_INSTALL_RPATH_USE_LINK_PATH | The install process may change the RPATH of the executable| TRUE or FALSE , default FALSE|
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

There's a Cmake\GlobalCompileOption.cmake file where you can add all the options that will be use by all the Executables and libraries.


## Executables and library option.
This is what you have to configure the most 

Add a cmakeList in the folder Executables or Libraries

Modify the CmakeList.txt

you habe to set theses option in terms of you want to use.

First you want to name your executable/library/project.
```cmake
project (ExecutableNAME CXX)
```
Replace "ExecutableName" with what you want to use.

You then want to add the headers of your programm  :
```cmake
set( ${PROJECT_NAME}_PUBLIC_HEADERS
		Executable4.h
	)
```
You can put them in an other folder like this :
```cmake
set( ${PROJECT_NAME}_PUBLIC_HEADERS
		Include/Executable4.h
	)
```

You can also add them as private header like this: 
```cmake
set( ${PROJECT_NAME}_PRIVATE_HEADERS
		Executable4.h
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
* for a header only lib
```cmake
set(${PROJECT_NAME}_BUILD_HEADERS_ONLY OFF )
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


If your library/Executable is dependent from anither, you can add the dependency like this :

```cmake
set(${PROJECT_NAME}_LINKER_DEPENDENCY CONAN_PKG::glm libCamera )
```
Here , in the exemple, my lib will be dependent of the glm Conan package and from the libCamera .

at the end , add the function that will manage all the options : 
```cmake
manage_target_options(${PROJECT_NAME})
```

## Step by step tutorial : Configure everything and add your own library and Executables.
### Root CMakeList.exe

### CMake/GlobalOption

### CMake/GlobalCompileOption

### Libraries folder

### Executables folder

### Invoke Cmake

## Conan

## Copy the Ressources directory to the build directory


## Test framework

You can add your own sub-Executables/sub-library by adding a test folder inside your own Executable : 


## Note
I refuse to support Apple anymore. Their policies are more and more aggresive toward devellopers. I canno't spend my time to support the "Apple only rendering pipeline, Apple only cu architecture etc"... 
A blog from a fellow roguelikedev who made a good summarry: https://www.gridsagegames.com/blog/2019/09/sorry-mac-users-apple-doesnt-care-about-us-devs/

## Build Tools
Inside Tools/Builders

## Hot-Loading (Windows Only for the moment)
To test the hot-loading, compile the Executable-hot-loading, launch it manually (in the folder build/bin/Debug) and let it run.
Open the project ofHotLoad
Change the content of the method loadedFunction and build the project.
The changes should appear.

## Thanks and ressources 
Thanks to filipdutescu for the modern cmake template which I've used to learn these ideas and techniques : https://github.com/filipdutescu/modern-cpp-template 
