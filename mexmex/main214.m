mex -v shrlibsample.c
%%
setenv('MW_MINGW64_LOC','D:\mingw64')
libname ='shrlibsample';hfile ='shrlibsample.h';
if not(libisloaded('shrlibsample'))
    loadlibrary('shrlibsample')
end

X = 13.3;
Xptr = libpointer('doublePtr',X);
a=calllib('shrlibsample','multDoubleRef',Xptr)
%%
a=calllib('shrlibsample','myFindWin','Notepad','Test.txt - ¼ÇÊÂ±¾')
dec2hex(a)
b=calllib('shrlibsample','postMouseMove',100,100)
%%
unloadlibrary shrlibsample