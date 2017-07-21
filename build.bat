@echo off
setlocal
cd /D %0\..

@call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86 >NUL

mkdir build
pushd build
@echo on
cmake ..
devenv ALL_BUILD.vcxproj /build debug
@echo off
pushd Debug
if %ERRORLEVEL% == 0 (
    echo Starting terrific.exe
    terrific.exe
)
popd
popd

endlocal
