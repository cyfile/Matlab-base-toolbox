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
#include "fetchimage.h"
#define EXPORTED_FUNCTION __declspec(dllexport)

#define IDT_TIMER 0
#define image_width 256
#define image_height 210
// const mwSize dims[] = {(mwSize)cy, (mwSize)cx, 3};
const size_t dims[3] = {image_height, image_width, 3};
// int cx = 256, cy = 210;
int cx = image_width, cy = image_height;
int cx1, cy1;

HANDLE hThreadCommand;

HWND hWndWar3;
HDC hdcScreen;
HDC hdcMemDC;
HBITMAP hbmScreen;

HGDIOBJ hPen;
BITMAPINFOHEADER bi = {0};
DWORD dwBmpSize;
// SIZE_T dwBmpSize;

HGLOBAL hMem;
char *lpMem;

HANDLE hInitDoneEvent;

char buffer[15] = {'\x12', '\x13', '\x14', '\x15', '\x16', 1, 2, 3, 4, 5};

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
    Sleep(100);
    mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0); // 按下
    mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);   // 弹起
}

DWORD WINAPI newThread(LPVOID lpParam)
{
    // timerID = SetTimer(NULL, IDT_TIMER, 10000, (TIMERPROC)MyTimerProc);
    UINT_PTR timerID = SetTimer(NULL, IDT_TIMER, 10000, NULL);
    printf(" = = = timer(%d) start!\n", timerID);

    RegisterHotKey(NULL, 1, MOD_ALT | MOD_CONTROL, 0x41); //0x41 is 'a'
    RegisterHotKey(NULL, 2, MOD_ALT | MOD_CONTROL, 0x42); //0x42 is 'b'
    RegisterHotKey(NULL, 3, MOD_ALT | MOD_CONTROL, 0x43); //0x42 is 'c'
    // printf(" = = = Hotkey 'CONTROL+ALT+b' registered\n\n");

    MSG msg = {0};
    while (GetMessage(&msg, NULL, 0, 0) != 0)
    {
        // printf(" = = = msg.message %d \n", msg.message);
        if (msg.message == WM_TIMER)
        {
            // DispatchMessage(&msg);
            printf(" = = = timer(%d) time(%d) up!\n", msg.wParam, msg.time);
            KillTimer(NULL, timerID);
            printf(" = = = KillTimer...\n");
            continue;
        }
        if (msg.message == WM_HOTKEY)
        {
            switch (msg.wParam)
            {
            case 1:
                printf(" = = = WM_HOTKEY A received, release initialize signal...\n");
                SetEvent(hInitDoneEvent);
                break;
            case 2:
                printf(" = = = WM_HOTKEY B received, reinitializing...\n");
                endFetchImage();
                initFetchImage(0, 0);
                break;
            case 3:
                printf(" = = = WM_HOTKEY C received, deconstructing...\n");
                endFetchImage();
                // if (!ResetEvent(hInitDoneEvent))
                // {
                //     MessageBox(NULL, L"Sets event object to nonsignaled failed!\n",
                //                L"RessetEven wrong!\n", MB_OK | MB_ICONWARNING);
                //     mexErrMsgIdAndTxt("MATLAB:FetchImage:ResetEvent",
                //                       "function was wrongly initialized.\n");
                // }
                break;
            }
            continue;
        }
    }

    return 0;
}

EXPORTED_FUNCTION void endFetchImage()
{
    BOOL bbb;
    bbb = DeleteObject(hbmScreen);
    printf(" # # # (%d=1)", bbb);
    bbb = DeleteObject(hdcMemDC);
    printf(" # (%d=1)", bbb);
    bbb = ReleaseDC(hWndWar3, hdcScreen);
    printf(" # (%d=1)", bbb);

    bbb = GlobalUnlock(hMem);
    printf(" # (%d=0)", bbb);
    HANDLE ccc = GlobalFree(hMem);
    printf(" # (%d=0)", ccc);

    bbb = CloseHandle(hInitDoneEvent);
    printf(" # (%d=1)", bbb);

    mexPrintf("\n  >>> >>> >>>  capture closed!  <<< <<< <<<\n");
    bbb = TerminateThread(hThreadCommand, 0);
    printf(" # # # TerminateThread return value[0=fail]: (%d)\n", bbb);
    CloseHandle(hThreadCommand);
}

EXPORTED_FUNCTION void initFetchImage(double x, double z)
{
    hThreadCommand = CreateThread(
        NULL,      // default security attributes
        0,         // use default stack size
        newThread, // thread function name
        NULL,      // argument to thread function
        0,         // use default creation flags
        0);        // returns the thread identifier
    printf(" [init] CreateThread : (0x%x)\n", hThreadCommand);

    hInitDoneEvent = CreateEvent(
        NULL,  // default security attributes
        TRUE,  // manual-reset event
        FALSE, // initial state is nonsignaled
        NULL); // object name
    printf(" [init] CreatedEvent : (0x%x)\n", hInitDoneEvent);

    printf("  >>> >>> >>>  Press CTRL+ALT+A to start initialization ...  <<< <<< <<<\n");
    DWORD dwWaitResult = WaitForSingleObject(hInitDoneEvent, 60000);
    printf(" [init] WaitForSingleObject return code[0x0 = signaled, 0x102 = time-out]: (0x%x)\n",
           dwWaitResult);

    hWndWar3 = FindWindow(L"OsWindow", L"Warcraft III");
    // MessageBox(NULL, L"Found Warcraft III\n", L"Succeed\n", MB_OK);
    if (hWndWar3 == NULL)
    {
        // hWndWar3 = GetDesktopWindow();
        cx1 = 133, cy1 = 581;
    }
    else
        cx1 = 133, cy1 = 681;
    GetWindowTextA(hWndWar3, buffer, 15);
    printf(" [init] FindWindow[%s] : (0x%x)\n", buffer, hWndWar3);

    // Retrieve the device context handle to get the client area of war3 window.
    // hdcScreen = GetWindowDC(hWndWar3); // hdcScreen = GetDC(hWndWar3);
    // printf(" [init] GetWindowDC : (0x%x)\n", hdcScreen);
    // ReleaseDC(hWndWar3, hdcScreen);
    // hdcScreen = GetDC(hWndWar3);
    // printf(" [init] GetDC : (0x%x)\n", hdcScreen);
    // ReleaseDC(hWndWar3, hdcScreen);
    hdcScreen = GetWindowDC(hWndWar3); // hdcScreen = GetDC(hWndWar3);
    printf(" [init] GetWindowDC : (0x%x)\n", hdcScreen);

    hbmScreen = CreateCompatibleBitmap(hdcScreen, cx, cy);
    hdcMemDC = CreateCompatibleDC(hdcScreen);
    SelectObject(hdcMemDC, hbmScreen);

    hPen = CreatePen(PS_SOLID, 2, RGB(0, 255, 0));

    bi.biSize = sizeof(BITMAPINFOHEADER);
    bi.biWidth = cx;
    //  If biHeight is negative, the bitmap is a top-down DIB
    // and its origin is the upper-left corner.
    bi.biHeight = -cy; // -cy
    bi.biPlanes = 1;
    bi.biBitCount = 24; // try 24 and 3 * cx * cy;
    bi.biCompression = BI_RGB;

    // GetDIBits remarks: "The scan lines must be aligned on a DWORD ..."
    // See https://docs.microsoft.com/en-us/windows/win32/api/wingdi/nf-wingdi-getdibits#remarks
    // 即需要保证 (cx * bi.biBitCount / 32) 为一个整数
    // 当 bi.biBitCount=24 时,要求cx能被4整除
    // 综合考虑 令 cx =256
    dwBmpSize = 3 * cx * cy; // bi.biBitCount/8 =3

    hMem = GlobalAlloc(GMEM_MOVEABLE, dwBmpSize);
    lpMem = (char *)GlobalLock(hMem);

    if (hInitDoneEvent == NULL) // && other objects== null
    {
        endFetchImage();
        mexPrintf("Somewhere in wrong! last error: (%d).\n", GetLastError());
        mexErrMsgIdAndTxt("MATLAB:initFetchImage:Ready Check",
                          "initialize failed.\n");
    }
    else
    {

        printf("  >>> >>> >>>  initialization complete, ready to capture!  <<< <<< <<<\n");
    }
}

// EXPORTED_FUNCTION void getMap(unsigned char pImage[256][210][3])
EXPORTED_FUNCTION void getMap(unsigned char * pImage)
{
    HGDIOBJ hPenOld = SelectObject(hdcScreen, hPen);
    MoveToEx(hdcScreen, cx1 - 1, cy1 - 1, (LPPOINT)NULL);
    LineTo(hdcScreen, cx1 - 1, cy1 + 1 + cy);
    LineTo(hdcScreen, cx1 + 1 + cx, cy1 + 1 + cy);
    LineTo(hdcScreen, cx1 + 1 + cx, cy1 - 1);
    LineTo(hdcScreen, cx1 - 1, cy1 - 1);
    SelectObject(hdcScreen, hPenOld);

    // Bit block transfer into our compatible memory DC.
    // so the compatible bitmap contain the region of war3 screen
    BitBlt(hdcMemDC, 0, 0, cx, cy, hdcScreen, cx1, cy1, SRCCOPY);
    // Gets the "bits" from the bitmap, and copies them into a buffer
    // that's pointed to by lpwar3image.
    int scanline = GetDIBits(hdcMemDC, hbmScreen, 0, (UINT)cy,
                             lpMem, (BITMAPINFO *)&bi, DIB_RGB_COLORS);
    printf(" [getmap] Copyed (%d) lines !(%d) bytes ! (%d) bits per pixel !\n",
           scanline, bi.biSizeImage, bi.biBitCount);


    int i, j, k;
    for (k = 0; k < 3; k++)
        for (j = 0; j < cy; j++)
            for (i = 0; i < cx; i++)
            {
                pImage[i * cy + j + k * cx * cy] = lpMem[(j * cx + i) * 3 + 2 - k];
                // pImage[j][i][k] = lpMem[(j * cx + i) * 3 + 2 - k];
            }

    printf(" [getmap] Captured one image form window(0x%x)!\n", hWndWar3);
    //int i;
    //for (i=0;i<size;i++)
    //    *x++ = * (buffer+i);
    // memcpy ( x, buffer, size );
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    //     int a = mxGetScalar(prhs[0]);
    //     double *b = mxGetPr(prhs[0]);
    //     mexPrintf("get int parameter from input: %f %d \n\n", a, a);
    //     mexPrintf("get first double element parameter from input: %f %d \n\n", b[0], b[0]);
    //     mexPrintf("get second double element parameter from input:%f %d \n\n", b[1], b[1]);

    //////////////////////////////////////////
    //
    //////////////////////////////////////////

    HGDIOBJ hPenOld = SelectObject(hdcScreen, hPen);
    MoveToEx(hdcScreen, cx1 - 1, cy1 - 1, (LPPOINT)NULL);
    LineTo(hdcScreen, cx1 - 1, cy1 + 1 + cy);
    LineTo(hdcScreen, cx1 + 1 + cx, cy1 + 1 + cy);
    LineTo(hdcScreen, cx1 + 1 + cx, cy1 - 1);
    LineTo(hdcScreen, cx1 - 1, cy1 - 1);
    SelectObject(hdcScreen, hPenOld);

    // Bit block transfer into our compatible memory DC.
    // so the compatible bitmap contain the region of war3 screen
    BitBlt(hdcMemDC, 0, 0, cx, cy, hdcScreen, cx1, cy1, SRCCOPY);
    // Gets the "bits" from the bitmap, and copies them into a buffer
    // that's pointed to by lpwar3image.
    int scanline = GetDIBits(hdcMemDC, hbmScreen, 0, (UINT)cy,
                             lpMem, (BITMAPINFO *)&bi, DIB_RGB_COLORS);
    printf(" [getmap] Copyed (%d) lines !(%d) bytes ! (%d) bits per pixel !\n",
           scanline, bi.biSizeImage, bi.biBitCount);

    plhs[0] = mxCreateNumericArray(3, dims, mxUINT8_CLASS, mxREAL);
    char *pImageOut = (char *)mxGetData(plhs[0]);

    int i, j, k;
    for (k = 0; k < 3; k++)
        for (j = 0; j < cy; j++)
            for (i = 0; i < cx; i++)
            {
                pImageOut[i * cy + j + k * cx * cy] = lpMem[(j * cx + i) * 3 + 2 - k];
            }

    mexPrintf(" [getmap] Captured one image form window(0x%x)!\n", hWndWar3);
}
