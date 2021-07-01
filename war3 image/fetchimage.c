#ifndef UNICODE
#define UNICODE
#endif
#ifndef _UNICODE
#define _UNICODE
#endif

#include <Windows.h>
#include <stdio.h>
#include "mex.h"
#include "mat.h"
#include "matrix.h"
#define EXPORTED_FUNCTION __declspec(dllexport)
// #include "fetchimage.h"

#define WAITFORCAPTUER_THREAD_MSG WM_USER + 100
#define REINITIALIZE_THREAD_MSG WM_USER + 101
#define image_width 256
#define image_height 210
// const mwSize dims[] = {(mwSize)cy, (mwSize)cx, 3};
const size_t dims[3] = {image_height, image_width, 3};
int cx = image_width, cy = image_height;

DWORD captureTID;
HWND hwindowWar3;

WCHAR *szName = (WCHAR *)L"War3ImageFileMapping";
HANDLE hMapFile;
char *pImageMap;

HANDLE hCaptureDoneEvent;

char img[10] = {'\x12', '\x13', '\x14', '\x15', '\x16', 1, 2, 3, 4, 5};

EXPORTED_FUNCTION void commandMove(double x, double y, double z)
{
    SetCursorPos(x, y);
    Sleep(z);
    //SetCursorPos(1440, 900);
    SetCursorPos(700, 400);
}
EXPORTED_FUNCTION void commandClick(double x, double y)
{
    // upper left corner: x=134, y=682
    // lower right corner: x=342, y=889
    SetCursorPos(x, y);
    mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0); // 按下
    // Sleep(100);
    mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0); // 弹起
}

EXPORTED_FUNCTION void endFetchImage()
{
    CloseHandle(hCaptureDoneEvent);

    UnmapViewOfFile(pImageMap);
    CloseHandle(hMapFile);
    mexPrintf("  >>> >>> >>>  capture closed!  <<< <<< <<<\n");
}

EXPORTED_FUNCTION void initFetchImage(double x, double z)
{
    /* get TID */
    OpenClipboard(NULL);
    HGLOBAL hMem = GetClipboardData(CF_TEXT);
    LPDWORD lpMem = (DWORD *)GlobalLock(hMem);
    captureTID = *lpMem;
    hwindowWar3 = *(HWND *)(lpMem + 1);
    GlobalUnlock(hMem);
    CloseClipboard();
    mexPrintf("Get captrue thread ID from clipboard: TID=(%d)\n", captureTID);
    mexPrintf("Get captrue window handle from clipboard: war3 window=(0x%x)\n",
              hwindowWar3);

    hMapFile = OpenFileMapping(
        FILE_MAP_READ, //    FILE_MAP_ALL_ACCESS,   // read/write access
        FALSE,         // do not inherit the name
        szName);       // name of mapping object
    mexPrintf("Open file mapping object: (0x%x).\n", hMapFile);

    pImageMap = (char *)MapViewOfFile(hMapFile,      // handle to map object
                                      FILE_MAP_READ, //  FILE_MAP_ALL_ACCESS,  // read/write permission
                                      0,
                                      0,
                                      0);
    mexPrintf("Get mapping file pointer: (0x%x).\n", pImageMap);

    hCaptureDoneEvent = OpenEvent(EVENT_MODIFY_STATE | SYNCHRONIZE, FALSE, L"CaptureDoneEvent");
    mexPrintf("Opened Event : (0x%x).\n", hCaptureDoneEvent);

    if (pImageMap == NULL) // && other objects== null
    {
        endFetchImage();
        mexPrintf("Somewhere in wrong! last error: (%d).\n", GetLastError());
        mexErrMsgIdAndTxt("MATLAB:initFetchImage:Ready Check",
                          "initialize failed.\n");
    }
    else
    {
        mexPrintf("  >>> >>> >>>  Ready to capture ...  <<< <<< <<<\n");
    }
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
//     int a = mxGetScalar(prhs[0]);
//     double *b = mxGetPr(prhs[0]);
//     mexPrintf("get int parameter from input: %f %d \n", a, a);
//     mexPrintf("get first double element parameter from input: %f %d \n", b[0], b[0]);
//     mexPrintf("get second double element parameter from input:%f %d \n", b[1], b[1]);

    //////////////////////////////////////////
    //
    //////////////////////////////////////////
    if (!ResetEvent(hCaptureDoneEvent))
    {
        MessageBox(NULL, L"Sets event object to nonsignaled failed!",
                   L"RessetEven wrong!", MB_OK | MB_ICONWARNING);
        mexErrMsgIdAndTxt("MATLAB:FetchImage:ResetEvent",
                          "function was wrongly initialized.\n");
    }

    // DWORD dwWait = WaitForSingleObject(hCaptureDoneEvent, 5000);
    // mexPrintf("WaitForSingleObject return code[0 = signaled]: (0x%x)\n", dwWait);

    PostThreadMessage(captureTID, WAITFORCAPTUER_THREAD_MSG, (WPARAM)NULL, (LPARAM)NULL);

    plhs[0] = mxCreateNumericArray(3, dims, mxUINT8_CLASS, mxREAL);
    char *pImageOut = (char *)mxGetData(plhs[0]);

    DWORD dwWaitResult = WaitForSingleObject(hCaptureDoneEvent, 5000);
    mexPrintf("WaitForSingleObject return code[0x0 = signaled, 0x102 = time-out]: (0x%x)\n",
              dwWaitResult);

    int i, j, k;
    for (k = 0; k < 3; k++)
        for (j = 0; j < cy; j++)
            for (i = 0; i < cx; i++)
            {
                pImageOut[i * cy + j + k * cx * cy] = pImageMap[(j * cx + i) * 3 + 2 - k];
            }

    mexPrintf("Captured one image form window(0x%x)!\n", hwindowWar3);
}
