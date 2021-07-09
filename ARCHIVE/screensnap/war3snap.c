// matlab mex file to snap the war3 screen
// compile to use>> mex screensnap.c user32.lib gdi32.lib

#include <windows.h>
#include <string.h>
#include "mex.h"

int cx1 = 133, cy1 = 681;
int cx = 256, cy = 210;
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    int recnum;
    int i, j, k;
    mwSize dims[3];
    char *pchar, *mloc;

    HWND hwin;
    HDC dc, memdc;
    
    HBITMAP hbitm, hold;
    BITMAPINFOHEADER binfoh;

    hwin = GetDesktopWindow();
    dc = GetWindowDC(hwin);
        
    memdc = CreateCompatibleDC(dc);
    mexPrintf("Handles: %08x %08x %08x !\n", hwin, dc, memdc);
    hbitm = CreateCompatibleBitmap(dc, cx, cy);
    if (hbitm == 0)
        mexErrMsgTxt("Fail to create a compatible bitmap!\n");
    if (!(hold = SelectObject(memdc, hbitm)))
        mexErrMsgTxt("Compatible Bitmap Selection!\n");


    //Copy color data for the entire display into a
    //bitmap that is selected into a compatible DC.

    if (!BitBlt(memdc, 0, 0, cx, cy, dc, cx1, cy1, SRCCOPY))
        mexErrMsgTxt("Screen to Compat Blt Failed");

    dims[0] = cy;
    dims[1] = cx;
    dims[2] = 3;

    plhs[0] = mxCreateNumericArray(3, dims, mxUINT8_CLASS, mxREAL);
    pchar = (char *)mxGetData(plhs[0]);
    binfoh.biSize = sizeof(BITMAPINFOHEADER);
    binfoh.biWidth = cx;
    binfoh.biHeight = -cy;
    binfoh.biPlanes = 1;
    binfoh.biBitCount = 24;
    binfoh.biCompression = BI_RGB;
    binfoh.biSizeImage = 0;
    binfoh.biXPelsPerMeter = 0;
    binfoh.biYPelsPerMeter = 0;
    binfoh.biClrUsed = 0;
    binfoh.biClrImportant = 0;
    mloc = (char *)mxMalloc(cx * cy * 3);
    recnum = GetDIBits(memdc, hbitm, 0, cy, mloc, (BITMAPINFO *)&binfoh, DIB_RGB_COLORS);
    mexPrintf("Copyed %d lines %d!\n", recnum, hbitm);
    for (k = 0; k < 3; k++)
        for (j = 0; j < cy; j++)
            for (i = 0; i < cx; i++)
            {
                pchar[i * cy + j + k * cx * cy] = mloc[(j * cx + i) * 3 + 2 - k];
            }
    mxFree(mloc);
    SelectObject(memdc, hold);
    DeleteDC(memdc);
    ReleaseDC(hwin, dc);
    DeleteObject(hbitm);

}