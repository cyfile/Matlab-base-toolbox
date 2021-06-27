setenv('MW_MINGW64_LOC','D:\mingw64')
%setenv('PATH', [getenv('PATH') ';E:\Program Files\Microsoft SDKs\Windows\v7.1\Bin'])
% mex -v yprime.c
% mex -v shrlibsample.c
% addpath(fullfile(matlabroot,'extern','examples','shrlib'))
% addpath('C:\Windows\System32' )
%%
libname ='example_dll';hfile =[libname,'.h'];
libname ='libmx';hfile ='matrix.h';
libname ='yprime';hfile ='yprime.h';
libname ='shrlibsample';hfile ='shrlibsample.h';
if not(libisloaded(libname))
    loadlibrary(libname,hfile,'alias','lib')
end
if not(libisloaded('shrlibsample'))
    loadlibrary('shrlibsample')
end
loadlibrary('user32.dll',@mxproto,'alias','lib');
%%
libfunctions('lib')
libfunctions('lib','-full')
libfunctionsview lib

a=calllib('lib','mexFunction',rand(3))
a=calllib('shrlibsample','myFindWin','Notepad','Test.txt - ¼ÇÊÂ±¾')
dec2hex(a)
calllib('shrlibsample','multDoubleArray',2,1)

calllib('shrlibsample','stringToUpper','somestr')

unloadlibrary shrlibsample
%%

[notfound,warnings] = loadlibrary('shrlibsample','shrlibsample.h','mfilename','mxproto')