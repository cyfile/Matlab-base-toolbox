setenv('MW_MINGW64_LOC','D:\mingw64')

mex -v -LD:\mingw64\x86_64-w64-mingw32\lib -llibuser32 -llibgdi32 war3snap.c

%%
disp('start!')
pause(10)
% A=screensnap(1);
A=war3snap(1);
sound( [1 -1 1 -1 1 -1 1])
%%
imshow(A)