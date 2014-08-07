call gyp.bat --depth=. pomelo.gyp -Dlibrary=static_library -DTO=pc

call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64

call devenv.exe pomelo.sln /Upgrade
call devenv.exe pomelo.sln /Rebuild Default /Project libpomelo


call devenv.exe deps/uv/uv.sln /Upgrade
call devenv.exe deps/uv/uv.sln /Rebuild Default /Project libuv


call devenv.exe deps/jansson/jansson.sln /Upgrade
call devenv.exe deps/jansson/jansson.sln /Rebuild Default /Project jansson


rd /s /q libWin
mkdir libWin

copy deps\uv\Default\lib\libuv.lib libWin\
copy deps\jansson\Default\lib\jansson.lib libWin\
copy Default\lib\libpomelo.lib libWin\

rd /s /q deps\uv\Default
rd /s /q deps\uv\Backup\
del deps\uv\*.sln
del deps\uv\*.vcproj
del deps\uv\*.vcxproj
del deps\uv\*.vcxproj.filters
del deps\uv\*.sdf
del deps\uv\*.suo
del deps\uv\UpgradeLog.htm

rd /s /q deps\jansson\Default
rd /s /q deps\jansson\Backup\
del deps\jansson\*.sln
del deps\jansson\*.vcproj
del deps\jansson\*.vcxproj
del deps\jansson\*.vcxproj.filters
del deps\jansson\*.sdf
del deps\jansson\*.suo
del deps\jansson\UpgradeLog.htm

rd /s /q Default
rd /s /q Backup\
del *.sln
del *.vcproj
del *.vcxproj
del *.vcxproj.filters
del *.sdf
del *.suo
del UpgradeLog.htm