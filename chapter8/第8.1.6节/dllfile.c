/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

/*dllfile.c*/
#include "dllfile.h"
DLLEXPORT mxArray * ReadFrameData(char * filename)
{
	FILE * fp=NULL;	
    	mxArray * pStruct = NULL;	
	fp =  fopen(filename,"rb");
	if(!fp)
	{
		char str[500];
		sprintf(str,"文件打开错误,fp = 0x%x",fp);
		return mxCreateString(str);
	}    
	pStruct = ReadData(fp);    
	fclose(fp);
	fp = NULL;    
	return pStruct;
}
