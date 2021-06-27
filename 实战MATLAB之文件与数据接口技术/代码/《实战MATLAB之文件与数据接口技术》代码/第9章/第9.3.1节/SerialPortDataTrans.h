/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

/* 程序 9-7 SerialPortDataTrans.h */
#ifndef _SERIAL_PORT_DATA_TRANS_H__
#define _SERIAL_PORT_DATA_TRANS_H__

/*引用的头文件*/
#include "mex.h"
#include <math.h>
#include <windows.h>
#include <stdlib.h>
#include <stdio.h>
#include <process.h>

/*发送包大小、接收包大小以及数据存储文件名称*/
#define SIZE_SENDING 16             //发送包大小
#define SIZE_RECEIVING 1024        //接收包大小
#define END_MARKER "$END"          //发送结束标识符

/*全局变量定义*/
char *g_file_name; //发送数据文件

/*线程函数声明*/
DWORD WINAPI Thread_Sending(char *sendPort);  //发送线程
DWORD WINAPI Thread_Receiving(char *receivePort);    //接收线程

#endif
