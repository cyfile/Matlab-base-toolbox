setenv('MW_MINGW64_LOC','D:\mingw64')
%%
unloadlibrary(libname)
mex -v fetchimage.c
mex -v cropwar3map.c -LD:\mingw64\x86_64-w64-mingw32\lib\ -lgdi32
mex -v war3mapshot.c -LD:\mingw64\x86_64-w64-mingw32\lib\ -lgdi32
%%
system("C:\Users\Administrator\Documents\vscode\Capturing war3\capture.exe &")
libname = 'fetchimage';
%%
libname = 'cropwar3map';
libname = 'war3mapshot';
if not(libisloaded(libname))
    [notfound,warnings]=loadlibrary(libname)
end
% libfunctions('fetchimage')
% libfunctions('fetchimage','-full')
% libfunctionsview fetchimage
aa=calllib(libname,'FindWar3Window')
dec2hex(aa)
%% 初始化之前 请先打开war3 和 capture程序,并且让capture 捕获到war3 窗口
calllib(libname,'initFetchImage',0,0)

% Xptr = libpointer('uint8Ptr', IMG)
% B=calllib(libname,'getMap',Xptr);
% get(Xptr)
% Xptr.value
%

%
disp('start!')
pause(1)
% calllib(libname,'commandClick',300, 770)
pause(10)
nCycle = 0;

while nCycle < 10
    
    %     A=fetchimage(5);
    %     A=cropwar3map(5);
    A=war3mapshot;
    %      A=war3snap;
    %     A=calllib(libname,'getMap',A);
    %     A = reshape(A,210,256,3);5
    % imshow(A)
    
    sound([1 -1 -1 -1 -1 1 -1 -1 -1 -1 1])
    %     calllib(libname,'commandMove',1, 1, 500)
    
    pause(3)
    P=getClickPoint(A)
    calllib(libname,'commandClick',P(1), P(2))
    
    %     boundaryTest(libname)
    
    Alast=A;
    Plast=P;
    
    
    nCycle = nCycle+1;
end
sound([1 -1 1 -1 1])
%
calllib(libname,'endFetchImage')
%%
unloadlibrary(libname)
