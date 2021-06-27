/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

#include "strToUpper.h"

DLLEXPORT char * strToUpper(char * str)
{
	int nLen;
	int kk = 0;
	nLen = strlen(str);
	for(kk=0;kk<nLen;kk++)
		{
			str[kk] = toupper(str[kk]);
		}
	return str;
}

DLLEXPORT void strToUpperCell(char ** pStr, int N)
{
	int kk;	
	for(kk=0;kk<N;kk++)
		{
			pStr[kk] = strToUpper(pStr[kk]);			
		}	
}
