/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

/*dllfile.h*/
#ifndef _DLL_FILE_H
#define _DLL_FILE_H
#include "basedef.h"
#include "matrix.h"
#include "string.h"
#include "stdio.h"
#ifndef NULL
#define NULL 0
#endif
DLLEXPORT mxArray * ReadFrameData(char * filename);
#endif

