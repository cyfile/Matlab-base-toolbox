/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

#ifndef _ENUM_EXAMPLE_H
#define _ENUM_EXAMPLE_H

#define DLLEXPORT  __declspec( dllexport )

typedef enum
{
    red=1,green=2,blue=4
}cE;

DLLEXPORT char* readEnum(cE val);

#endif
