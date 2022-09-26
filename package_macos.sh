#!/usr/bin/env zsh

version=5.0.0

export CONAN_REVISIONS_ENABLED=1

scriptLocation=$(dirname "$(readlink -f "$0")")

mkdir -p build/x86_64
cd build/x86_64

conan install ../../ --build=missing -pr:h ../../macos_x86_64.profile -pr:b default

find bin -type f -name "*.dylib" -exec "${scriptLocation}/macos_fix_rpath.py" {} \;

cd ..
mkdir -p arm64
cd arm64

conan install ../../ --build=missing -pr:h ../../macos_arm64.profile -pr:b default

find bin -type f -name "*.dylib" -exec "${scriptLocation}/macos_fix_rpath.py" {} \;

cd ..

mkdir -p universal 
cd universal

rm -Rf libs
rm -Rf bin

cp -a ../x86_64/bin .

find bin -type f -name "*.dylib" -exec lipo -create ../x86_64/{} ../arm64/{} -output {} \;
find bin -type f -name "*.dylib" -exec lipo -info {} \;
find bin -type f -name "*.dylib" -exec codesign -vvvv --sign "$1" --timestamp {} \;
find bin -type f -name "*.dylib" -exec otool -L {} \;

mv bin libs

cd ../
mkdir -p output

pkgbuild --root universal \
         --identifier "com.sourceforge.audacity.ffmpegLibrariesForAudacity.pkg" \
         --version "${version}" \
         --install-location "/Library/Application Support/audacity" \
         "output/FFmpeg_${version}_for_Audacity_on_macOS.pkg"

codesign -vvvv --sign "$1" --timestamp "output/FFmpeg_${version}_for_Audacity_on_macOS.pkg"
