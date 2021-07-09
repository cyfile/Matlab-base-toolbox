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
int cx1 = 133, cy1 = 681;

HWND hWndScreen;
HDC hdcScreen;
HDC hdcMemDC;
HBITMAP hbmScreen;
HBITMAP hbmOld;

HGDIOBJ hPen;
BITMAPINFOHEADER bi = {0};
DWORD dwBmpSize;

HGLOBAL hMem;
char *lpMem;

INPUT m_InPut[2] = {0};

char buffer[20] = {'\xa', '\x12', '\x13', '\xAB', 'a', 'z', 'A', 'Z', 2, 3, 4, 5};

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
    // mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0); // 按下
    // mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);   // 弹起

    SendInput(2, m_InPut, sizeof(INPUT));
}

EXPORTED_FUNCTION double FindWar3Window()
{
    HWND hWndWar3 = FindWindow(L"OsWindow", L"Warcraft III");
    // MessageBox(NULL, L"Found Warcraft III\n", L"Succeed\n", MB_OK);
    GetWindowTextA(hWndWar3, buffer, 15);
    printf(" [init] FindWindow[%s] : (0x%x)\n", buffer, hWndWar3);
    return (double)(DWORD)hWndWar3;
}

EXPORTED_FUNCTION void endFetchImage()
{
    DeleteObject(hPen);
    SelectObject(hdcMemDC, hbmOld);

    BOOL bbb;

    bbb = DeleteObject(hbmScreen);
    printf(" # # # [(%d)=1](%d)", bbb, GetLastError());
    bbb = DeleteObject(hdcMemDC);
    printf(" # [(%d)=1](%d)", bbb, GetLastError());
    bbb = ReleaseDC(hWndScreen, hdcScreen);
    printf(" # [(%d)=1](%d)", bbb, GetLastError());

    bbb = GlobalUnlock(hMem);
    printf(" # [(%d)=0]", bbb);
    HANDLE ccc = GlobalFree(hMem);
    printf(" # [(%d)=0]\n", ccc);

    mexPrintf("  >>> >>> >>>  capture closed!  <<< <<< <<<\n");
}

EXPORTED_FUNCTION void initFetchImage(double x, double z)
{

    hWndScreen = GetDesktopWindow();
    hdcScreen = GetWindowDC(hWndScreen); // hdcScreen = GetDC(hWndWar3);
    printf(" [init] GetWindowDC : (0x%x)\n", hdcScreen);

    hbmScreen = CreateCompatibleBitmap(hdcScreen, cx, cy);
    hdcMemDC = CreateCompatibleDC(hdcScreen);
    hbmOld = SelectObject(hdcMemDC, hbmScreen);

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

    m_InPut[0].type = m_InPut[1].type = INPUT_MOUSE;
    m_InPut[0].mi.dwFlags = MOUSEEVENTF_LEFTDOWN;
    m_InPut[1].mi.dwFlags = MOUSEEVENTF_LEFTUP;

    if (NULL) // && other objects== null
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

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    //////////////////////////////////////////
    //     int a = mxGetScalar(prhs[0]);
    //     double *b = mxGetPr(prhs[0]);
    //     mexPrintf("get int parameter from input: %f %d \n\n", a, a);
    //     mexPrintf("get first double element parameter from input: %f %d \n\n", b[0], b[0]);
    //     mexPrintf("get second double element parameter from input:%f %d \n\n", b[1], b[1]);
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
    GetDIBits(hdcMemDC, hbmScreen, 0, (UINT)cy,
              lpMem, (BITMAPINFO *)&bi, DIB_RGB_COLORS);

    plhs[0] = mxCreateNumericArray(3, dims, mxUINT8_CLASS, mxREAL);
    char *pImageOut = (char *)mxGetData(plhs[0]);

    int i, j, k;
    for (k = 0; k < 3; k++)
        for (j = 0; j < cy; j++)
            for (i = 0; i < cx; i++)
            {
                pImageOut[i * cy + j + k * cx * cy] = lpMem[(j * cx + i) * 3 + 2 - k];
            }

    printf(" [getmap] Captured one image (%d bytes) !\n", bi.biSizeImage);
}
