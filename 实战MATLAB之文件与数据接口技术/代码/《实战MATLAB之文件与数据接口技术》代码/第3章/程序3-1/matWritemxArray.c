/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

/* 程序 3-1 matWritemxArray.c */
/* matWritemxArray.c文件内容 */
#include "memory.h"
#include "mat.h"

#ifndef NULL
#define NULL 0
#endif

int main(int argc, char* argv[]) 
{
	MATFile *pmat;
	mxArray *pa1, *pa2, *pa3;
	double * pdata = NULL;
	double data[9] = { 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0 };
	const char *file = "mattest.mat";	
	char ** dir;
	int ndir;
	int status,i; 
	
	printf("正在创建文件 %s...\n\n", file);
	pmat = matOpen(file, "w");
	if (pmat == NULL)
	{
		printf("文件 %s 创建出错\n", file);
		return -1;
	}
	
	pa1 = mxCreateDoubleMatrix(3,3,mxREAL);
	if (pa1 == NULL) 
	{
		printf("创建mxArray结构失败，pa1.\n");
matClose(file);
		return -1;
	}
	/*构造阵列pa1的数据*/
	pdata = mxGetPr(pa1);
	for(i=0;i<mxGetM(pa1)*mxGetN(pa1);i++)
	{
		pdata[i]=mxGetM(pa1)*mxGetN(pa1)-i+1;
	}
	
	pa2 = mxCreateDoubleMatrix(3,3,mxREAL);
	if (pa2 == NULL) 
	{
		printf("创建mxArray结构失败，pa2.\n");
matClose(file);
		return -1;
	}
	/*构造pa2数据*/
	memcpy((void *)(mxGetPr(pa2)), (void *)data, sizeof(data));

	pa3 = mxCreateString("MATLAB: the language of technical computing");
	if (pa3 == NULL) 
	{
		printf("创建mxArray结构失败，pa3.\n");
matClose(file);
return -1;
	}
	
	status = matPutVariable(pmat, "LocalDouble", pa1);
	if (status != 0) 
	{
		printf("%s :  matPutVariable 函数出错, %d行\n",	__FILE__, __LINE__);
		return -1;
	} 
	
	status = matPutVariableAsGlobal(pmat, "GlobalDouble", pa2);
	if (status != 0) 
	{
		printf("%s: matPutVariableAsGlobal出错, %d行\n", __FILE__, __LINE__);
		return -1;
	} 
	
	status = matPutVariable(pmat, "LocalString", pa3);
	if (status != 0) 
	{
		printf("%s :  matPutVariable 函数出错, %d行\n",	__FILE__, __LINE__);
		return -1;
	} 
	
		
	mxDestroyArray(pa1);
	mxDestroyArray(pa2);
	mxDestroyArray(pa3);

	printf("文件 %s 创建成功!\n\n", file);
	
	if (matClose(pmat) != 0) 
	{
		printf("关闭 %s 文件出错!\n",file);
		return -1;
	}
	
  /*重新打开生成的MAT文件，并将其中的变量显示出来*/
	pmat = matOpen(file, "r");
	if (pmat == NULL) 
	{
		printf("打开文件 %s 出错!\n", file);
		return -1;
	}
	
	dir = matGetDir(pmat, &ndir);
	if (dir == NULL) 
	{
		printf("MAT文件 %s 没有变量存在!\n", file);
		return(1);
	}
	else 
	{
		printf("MAT 文件%s 中的变量有:\n", file);
		for (i=0; i < ndir; i++)
		{
			printf("\t%s\n",dir[i]);
		}
	}	
	
	if (matClose(pmat) != 0) 
	{
		printf("关闭 %s 文件出错!\n",file);
		return(EXIT_FAILURE);
	}		
	return 0;
}
