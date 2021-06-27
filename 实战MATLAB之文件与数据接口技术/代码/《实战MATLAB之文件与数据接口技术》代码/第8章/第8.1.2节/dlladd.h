/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

/*  dlladd.h */

#ifndef _DLL_ADD_H
#define _DLL_ADD_H
 
#define DLLEXPORT  __declspec( dllexport )
 
#include "matrix.h"
 
DLLEXPORT double addDoubleS(double v1,double v2);
DLLEXPORT void addDoubleV(double * v1,const double * v2, int size);

 
#endif
