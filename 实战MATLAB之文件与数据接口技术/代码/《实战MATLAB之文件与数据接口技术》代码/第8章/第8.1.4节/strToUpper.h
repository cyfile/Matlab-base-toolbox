/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

#ifndef __STR_TO_UPPER_H_
#define __STR_TO_UPPER_H_

#define DLLEXPORT  __declspec( dllexport )

DLLEXPORT char * strToUpper(char * str);
DLLEXPORT void strToUpperCell(char ** pStr, int N);

#endif
