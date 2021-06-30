setenv('MW_MINGW64_LOC','D:\mingw64')
%%
mex -v fetchimage.c
%%
system("C:\Users\Administrator\Documents\vscode\Capturing war3\capture.exe &")
%%
if not(libisloaded('fetchimage'))
    [notfound,warnings]=loadlibrary('fetchimage')
end
% libfunctions('fetchimage')
% libfunctions('fetchimage','-full')
% libfunctionsview fetchimage
%% 初始化之前 请先打开war3 和 capture程序,并且让capture 捕获到war3 窗口
calllib('fetchimage','initFetchImage',0,0)
%%
pause(30)
A=fetchimage(5);
imshow(A)
calllib('fetchimage','commandMove',1, 1, 1000)
%%
calllib('fetchimage','endFetchImage')
unloadlibrary fetchimage