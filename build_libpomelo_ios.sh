#用这个编译libpomelo库以及它依赖的uv和jansson
#编译以后会把ios版和模拟器版合并成一个文件后放入lib目录。
#libpomelo本身提供的两个build命令连续使用的话，会造成第二个编译的无法正常使用
#所以这里在编译好一个后彻底删除build目录再编译第二个。

./pomelo_gyp -DTO=ios

rm -rf ./build
rm -rf ./deps/jansson/build
rm -rf ./deps/uv/build

xcodebuild -project ./deps/jansson/jansson.xcodeproj -sdk iphonesimulator7.1
xcodebuild -project ./deps/uv/uv.xcodeproj -sdk iphonesimulator7.1
xcodebuild -project ./pomelo.xcodeproj -sdk iphonesimulator7.1

rm -rf ./libIOS_sim
mkdir ./libIOS_sim

cp ./build/Default-iphonesimulator/libpomelo.a ./libIOS_sim/libpomelo.a
cp ./deps/jansson/build/Default-iphonesimulator/libjansson.a ./libIOS_sim/libjansson.a
cp ./deps/uv/build/Default-iphonesimulator/libuv.a ./libIOS_sim/libuv.a

rm -rf ./build
rm -rf ./deps/jansson/build
rm -rf ./deps/uv/build

xcodebuild -project ./deps/jansson/jansson.xcodeproj -sdk iphoneos7.1
xcodebuild -project ./deps/uv/uv.xcodeproj -sdk iphoneos7.1
xcodebuild -project ./pomelo.xcodeproj -sdk iphoneos7.1

rm -rf ./libIOS_tmp
mkdir ./libIOS_tmp
cp ./build/Default-iphoneos/libpomelo.a ./libIOS_tmp/libpomelo.a
cp ./deps/jansson/build/Default-iphoneos/libjansson.a ./libIOS_tmp/libjansson.a
cp ./deps/uv/build/Default-iphoneos/libuv.a ./libIOS_tmp/libuv.a

rm -rf ./build
rm -rf ./deps/jansson/build
rm -rf ./deps/uv/build

rm -rf ./libiOS
mkdir ./libiOS

lipo -create ./libIOS_tmp/libpomelo.a  ./libIOS_sim/libpomelo.a  -output ./libiOS/libpomelo.a
lipo -create ./libIOS_tmp/libjansson.a ./libIOS_sim/libjansson.a  -output ./libiOS/libjansson.a
lipo -create ./libIOS_tmp/libuv.a ./libIOS_sim/libuv.a  -output ./libiOS/libuv.a

rm -rf ./libIOS_sim
rm -rf ./libIOS_tmp

rm -rf pomelo.xcodeproj
rm -rf deps/jansson/jansson.xcodeproj
rm -rf deps/uv/uv.xcodeproj
