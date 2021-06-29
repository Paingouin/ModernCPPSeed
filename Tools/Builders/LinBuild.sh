#!/bin/bash

cd ../..
mkdir Build
cd Build

/usr/local/bin/cmake .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=/usr/bin/g++ -DCMAKE_INSTALL_PREFIX=../install

