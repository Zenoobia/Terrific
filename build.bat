@echo off

mkdir build
pushd build
cl -Zi ..\src\win32_terrific.cpp
popd

