/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

#ifndef _COLOR_TO_GRAY_H
#define _COLOR_TO_GRAY_H

#define DLLEXPORT  __declspec( dllexport )

//#include "matrix.h"

typedef struct _COLOR
{
	double r;
	double g;
	double b;
}doubleColor;


DLLEXPORT double color2gray(doubleColor c);
#endif
