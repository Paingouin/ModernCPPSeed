@echo off
echo ****************************************
echo * Executable building folder creator V. 1.5 *
echo ****************************************

REM cmake --build <build_directory> --target install --config <desired_config>

REM if exist "%~dp0/Build" (
REM 	rmdir  /S /Q "%~dp0/Build"
REM )

cd ../..
mkdir Build_Release
cd Build_Release

cmake .. -G"Visual Studio 15 2017" -Ax64  -DCMAKE_INSTALL_PREFIX=../install_Release -DCMAKE_BUILD_TYPE=Release 
cmake --build . --target install --config Release -j 4

cd ..
mkdir Build_Debug
cd Build_Debug

cmake .. -G"Visual Studio 15 2017" -Ax64  -DCMAKE_INSTALL_PREFIX=../install_Debug -DCMAKE_BUILD_TYPE=Debug
cmake --build . --target install --config Debug -j 4

rem package phase
REM cmake --build . --target Package --config Debug			

pause