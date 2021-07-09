setenv('MW_MINGW64_LOC','D:\mingw64')
% setenv('PATH', [getenv('PATH') ';E:\Program Files\Microsoft SDKs\Windows\v7.1\Bin'])
% mex -v yprime.c
% addpath(fullfile(matlabroot,'extern','examples','shrlib'))
% addpath('C:\Windows\System32' )
%%
libname ='example_dll';hfile =[libname,'.h'];
libname ='libmx';hfile ='matrix.h';
libname ='yprime';hfile ='yprime.h';

if not(libisloaded(libname))
    % [notfound,warnings] = loadlibrary('shrlibsample','shrlibsample.h','mfilename','mxproto')
    % loadlibrary('user32.dll',@mxproto,'alias','lib');
    % [notfound,warnings] = loadlibrary(libname,hfile,'alias','lib')
    [notfound,warnings] = loadlibrary(libname,hfile)
end
%%
libfunctions('lib')
libfunctions('lib','-full')
libfunctionsview lib
%%
a=calllib('lib','mexFunction',rand(3))


%%
unloadlibrary(libname)


