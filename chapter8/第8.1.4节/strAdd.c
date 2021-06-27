/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

#include "strAdd.h"
#define  nMaxStrNum 1024
char ** g_ppStr = NULL;
int g_numStr = 0;
DLLEXPORT char** ppStrAdd(char *str)
{
	int kk;
	int nlen;
	if(g_ppStr==NULL)
	{
		g_ppStr = (char**)malloc(sizeof(char*)*nMaxStrNum);
		for(kk = 0;kk<nMaxStrNum;kk++)
		{
			g_ppStr[kk] = NULL;
		}
	}	
	nlen = strlen(str);
	g_ppStr[g_numStr] = (char*)malloc(sizeof(char)*nlen);
	strcpy(g_ppStr[g_numStr],str);
	g_numStr = (g_numStr+1)%nMaxStrNum;
	return g_ppStr;
}
DLLEXPORT void destroyPP()
{
    int kk;
    if(g_ppStr != NULL)
    {
        for(kk=0; kk<nMaxStrNum; kk++)
        {
            if(g_ppStr[kk] != NULL)
                free(g_ppStr[kk]);
        }
        free(g_ppStr);
    }
}