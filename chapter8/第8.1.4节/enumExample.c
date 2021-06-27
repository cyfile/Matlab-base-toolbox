/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

#include "enumExample.h"

DLLEXPORT char* readEnum(cE val) 
{
	  switch (val) {
	    case 1 :return "输入red";
	    case 2: return "输入green";
	    case 4: return "输入 blue";
	    default : return "输入选项未定义";
	  }
}
