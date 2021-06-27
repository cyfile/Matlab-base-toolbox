/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

#include "dispVoid.h"
char * g_data = NULL;
DLLEXPORT char* dispVoid(void * pdata, char * type)
{
	int maxStrLen = 255;	
	if(pdata==NULL)
		{
			return;
		}
	if(g_data==NULL)
		{
			g_data = (char*)malloc((maxStrLen+1)*sizeof(char));
			g_data[maxStrLen] = '\0';
		}
	if(strcmp(type,"char")==0)
		{
			int nlen;
			nlen=(strlen(pdata)>maxStrLen)?maxStrLen:strlen(pdata);
			memcpy(g_data,pdata,nlen);
			g_data[nlen] = '\0';
			return g_data;
		}
	if(strcmp(type,"single")==0)
		{
			sprintf(g_data,"%f",*(float*)pdata);
			return g_data;
		}
	if(strcmp(type,"double")==0)
		{
			sprintf(g_data,"%f",*(double*)pdata);
			return g_data;
		}
	if(strcmp(type,"int32")==0)
		{
			sprintf(g_data,"%d",*(int*)pdata);
			return g_data;
		}
	if(strcmp(type,"int8")==0)
		{
			sprintf(g_data,"%d",*(char*)pdata);
			return g_data;
		}
	sprintf(g_data,"%s,%s",type,"未知数据类型");
	return g_data;	
}
