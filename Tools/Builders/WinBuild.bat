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

rem package phase
REM cmake --build . --target Package --config Debug

pause	