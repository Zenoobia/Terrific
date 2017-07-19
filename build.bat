@echo off

mkdir build
pushd build
cmake ..
devenv ALL_BUILD.vcxproj /build debug
popd

