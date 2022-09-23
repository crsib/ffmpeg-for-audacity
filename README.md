## Windows

```
mkdir build
cd build
mkdir win64
cd win64
conan install ../.. --build=missing -pr:h ../../msvc2022_x86_64.profile -pr:b default
cd ..
mkdir win32
cd win32
conan install ../.. --build=missing -pr:h ../../msvc2022_x86.profile -pr:b default
``` 

