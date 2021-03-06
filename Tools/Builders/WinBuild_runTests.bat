@echo off
echo ****************************************
echo * Executable building folder creator V. 1.5 *
echo ****************************************

REM cmake --build <build_directory> --target install --config <desired_config>

REM if exist "%~dp0/Build" (
REM 	rmdir  /S /Q "%~dp0/Build"
REM )

cd ../..
mkdir Build
cd Build

cmake .. -G"Visual Studio 15 2017" -Ax64  -DCMAKE_INSTALL_PREFIX=../install
cmake --build . --config Release -j 4
cmake --build . --target RUN_TESTS --config Release -j 4

rem ctest -C Release

rem package phase
REM cmake --build . --target Package --config Debug

pause