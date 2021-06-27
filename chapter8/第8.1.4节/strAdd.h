/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

#ifndef _STR_ADD_H
#define _STR_ADD_H

#include "matrix.h"
#define DLLEXPORT  __declspec( dllexport )
DLLEXPORT char** ppStrAdd(char *str);
DLLEXPORT void destroyPP();
#endif
