% edit(fullfile(matlabroot,'extern','examples','shrlib','shrlibsample.c'))
% mex -v shrlibsample.c
%%
setenv('MW_MINGW64_LOC','D:\mingw64')
% libname ='shrlibsample';hfile ='shrlibsample.h';
if not(libisloaded('shrlibsample'))
    tmp=loadlibrary('shrlibsample')
end
%%
X = 13.3;
Xptr = libpointer('doublePtr',X);
NAptr=calllib('shrlibsample','multDoubleRef',Xptr)
get(Xptr)
Xptr.value
%%
Xptr = libpointer('doublePtr',[3 4 ; 5 6]);
calllib('shrlibsample','multDoubleArray',Xptr,3)
Xptr.value

a=calllib('shrlibsample','multDoubleArray',[2,3;4 5],3)
%%
X = uint8([2,3;4 5]);
Xptr = libpointer('uint8Ptr', X)
a=calllib('shrlibsample','assignUint8Array',Xptr,3)
get(Xptr)
Xptr.value

a=calllib('shrlibsample','assignUint8Array',uint8([2,3;4 5]),3)

%%
a=calllib('shrlibsample','stringToUpper','somestr')
%%
a=calllib('shrlibsample','myFindWin','Notepad','Test.txt - ¼ÇÊÂ±¾')
dec2hex(a)
b=calllib('shrlibsample','postMouseMove',100,100)
%%
unloadlibrary shrlibsample