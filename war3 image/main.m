setenv('MW_MINGW64_LOC','D:\mingw64')
%%
mex -v getimage.c
%%
system("C:\Users\Administrator\Documents\vscode\Capturing war3\capture.exe &")

if not(libisloaded('getimage'))
    [notfound,warnings]=loadlibrary('getimage')
end
calllib('getimage','initReceiveFun',2,1)
A=getimage(5);

unloadlibrary getimage