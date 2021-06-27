#ifndef UNICODE
#define UNICODE
#endif
#ifndef _UNICODE
#define _UNICODE
#endif

#include <Windows.h>
#include "stdio.h"
#include "mex.h"
#include "mat.h"
#include "matrix.h"
#define EXPORTED_FUNCTION __declspec(dllexport)
// #include "getimage.h"

#define image_width 256
#define image_height 210
int cx = image_width, cy = image_height;

WCHAR * szName =(WCHAR * ) L"War3ImageFileMapping";

int outvar = 3;
int captureTID;
char img[10] = {'\x12', '\x13', '\x14', '\x15', '\x16', 1, 2, 3, 4, 5};

// EXPORTED_FUNCTION unsigned int myFindWin(char *winClass,char *winName)
// {
//     HWND hwin = FindWindowA(  (LPCSTR) winClass, (LPCSTR) winName );
//     return hwin ;
// }

EXPORTED_FUNCTION void initReceiveFun(double x ,double z)
{
    /* Multiple each element of the array by 3 */
    int i;
    mexPrintf("%d",captureTID);
    OpenClipboard(NULL);
    HGLOBAL hMem = GetClipboardData(CF_TEXT);
    LPDWORD lpMem= (DWORD *)GlobalLock(hMem);
    mexPrintf("(%d) (%d)",*lpMem,*(lpMem+1)) ;
    
    captureTID = *lpMem;
    outvar = *(lpMem+1);
    GlobalUnlock(hMem);
    CloseClipboard();
}

        
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    double *datap;
    mexPrintf("outvar(start) %d\n", outvar);

    int a = mxGetScalar(prhs[0]);
    double *b = mxGetPr(prhs[0]);
    mexPrintf("hello,world! %f %d %f %d\n", b[0], b[0], a, a);
    outvar = a;

    //////////////////////////////////////////

    //////////////////////////////////////////
    HANDLE hMapFile;
    char *pBuf;

    hMapFile = OpenFileMapping(
        FILE_MAP_READ, //    FILE_MAP_ALL_ACCESS,   // read/write access
        FALSE,         // do not inherit the name
        szName);       // name of mapping object

    if (hMapFile == NULL)
    {
        mexPrintf("Could not open file mapping object (%d).\n", GetLastError());
        mexErrMsgIdAndTxt("MATLAB:mexfunction:OpenFileMapping",
                          "Cannot OpenFileMapping.\n");
    }

    pBuf = (char *)MapViewOfFile(hMapFile,      // handle to map object
                                 FILE_MAP_READ, //  FILE_MAP_ALL_ACCESS,  // read/write permission
                                 0,
                                 0,
                                 0);

    if (pBuf == NULL)
    {
        mexPrintf("Could not map view of file (%d).\n", GetLastError());
        CloseHandle(hMapFile);
        mexErrMsgIdAndTxt("MATLAB:mexfunction:MapViewOfFile",
                          "Cannot MapViewOfFile.\n");
    }

    const mwSize dims[] = {(mwSize)cy, (mwSize)cx, 3};
    plhs[0] = mxCreateNumericArray(3, dims, mxUINT8_CLASS, mxREAL);
    char *pimageOut = (char *)mxGetData(plhs[0]);
    int i, j, k;

    for (k = 0; k < 3; k++)
        for (j = 0; j < cy; j++)
            for (i = 0; i < cx; i++)
            {
                pimageOut[i * cy + j + k * cx * cy] = pBuf[(j * cx + i) * 3 + 2 - k];
            }

//     MessageBox(NULL, L"information", L"title", MB_OK);

    UnmapViewOfFile(pBuf);
    CloseHandle(hMapFile);

    mexPrintf("outvar(end)= %d\n", outvar);
}


