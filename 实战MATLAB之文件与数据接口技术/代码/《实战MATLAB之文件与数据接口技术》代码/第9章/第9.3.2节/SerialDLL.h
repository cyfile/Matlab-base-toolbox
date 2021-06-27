/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

/*包含的头文件*/
#include <math.h>
#include <windows.h>
#include <stdlib.h>
#include <stdio.h>
#include <process.h>

#ifndef _SERIAL_DLL_U__
#define _SERIAL_DLL_U__
#define RECEIVING_BLOCK_SIZE 1024
#define RECEIVING_BLOCK_NUM 10
#define DLLEXPORT  __declspec( dllexport )

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */
	DLLEXPORT int ReadData(char* COMM);
#ifdef __cplusplus
};
#endif /* __cplusplus */
#endif
