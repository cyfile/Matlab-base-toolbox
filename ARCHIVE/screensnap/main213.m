setenv('MW_MINGW64_LOC','D:\mingw64')

mex -LD:\mingw64\x86_64-w64-mingw32\lib -llibuser32 -llibgdi32 screensnap.c

