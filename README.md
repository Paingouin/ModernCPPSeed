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
Now that we know how to launch cmake , I will explain how to configure it, without all the schlimlink 

First, at the root of the project, you have a CMakeList.txt, this one is used : 
* name our project
* read the Global Options
* launch Conan
* read the others CmakeLists.txt (the one of our batches/libraries)

## Global Options

Global option can be found in Cmake\GlobalOptions.cmake

These impact all the batches/library.

| Options       |    Description        | Value possible  |
| ------------- |-------------| -----|
|CMAKE_SKIP_BUILD_RPATH |  | TRUE or FALSE |
|CMAKE_INSTALL_RPATH_USE_LINK_PATH |  | TRUE or FALSE , default TRUE|
|CMAKE_INSTALL_RPATH_USE_LINK_PATH |  | TRUE or FALSE , default FALSE|
|WARNINGS_AS_ERRORS | Enable the warning as error for all project | ON or OFF , default OFF|
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
