#!/bin/bash


cd ../..
mkdir Build_Release
cd Build_Release

/usr/local/bin/cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=/usr/bin/g++ -DCMAKE_INSTALL_PREFIX=../install_Release
cmake --build . --target install --config Release -j 4

cd ..
mkdir Build_Debug
cd Build_Debug

/usr/local/bin/cmake .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=/usr/bin/g++ -DCMAKE_INSTALL_PREFIX=../install_Debug
cmake --build . --target install --config Debug -j 4
