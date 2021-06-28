setenv('MW_MINGW64_LOC','D:\mingw64')
%%
mex -v fetchimage.c
%%
system("C:\Users\Administrator\Documents\vscode\Capturing war3\capture.exe &")

if not(libisloaded('fetchimage'))
    [notfound,warnings]=loadlibrary('fetchimage')
end
% libfunctions('fetchimage')
% libfunctions('fetchimage','-full')
% libfunctionsview fetchimage
%%
calllib('fetchimage','initFetchImage',2,1)

A=fetchimage(5);
imshow(A)
calllib('fetchimage','commandMove',100, 100, 1000)

calllib('fetchimage','endFetchImage')
unloadlibrary fetchimage