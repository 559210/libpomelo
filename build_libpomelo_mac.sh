./pomelo_gyp

rm -rf ./build
rm -rf ./deps/jansson/build
rm -rf ./deps/uv/build

xcodebuild -project ./deps/jansson/jansson.xcodeproj -arch x86_64 -arch i386
xcodebuild -project ./deps/uv/uv.xcodeproj -arch x86_64 -arch i386
xcodebuild -target "libpomelo" -project ./pomelo.xcodeproj -arch x86_64 -arch i386

rm -rf ./libMac
mkdir ./libMac

cp ./build/Default/libpomelo.a ./libMac/libpomelo.a
cp ./deps/jansson/build/Default/libjansson.a ./libMac/libjansson.a
cp ./deps/uv/build/Default/libuv.a ./libMac/libuv.a


rm -rf pomelo.xcodeproj
rm -rf deps/jansson/jansson.xcodeproj
rm -rf deps/uv/uv.xcodeproj
rm -rf ./build
rm -rf ./deps/jansson/build
rm -rf ./deps/uv/build


