/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

/* 程序 3-2 matReadmxArray.c */
/*matReadmxArray.c文件内容*/
#include <stdio.h>
#include "string.h"
#include "mat.h"

#define _FILE_NAME_LEN 100

int analyze_matfile(const char *file) 
{
	MATFile *pmat;
	char **dir;
	const char *name;
	int ndir;
	int i;
	mxArray *pa;
	
	printf("开始读取MAT文件 %s...\n\n", file);
	
	pmat = matOpen(file, "r");
	if (pmat == NULL) 
	{
		printf("文件%s打开出错!\n", file);
		return(1);
	}
	
	
	dir = matGetDir(pmat, &ndir);	
	if (dir == NULL) 
	{
		printf("当前MAT文件%s中没有任何变量!\n", file);
		return(1);
	}
	else
	{
		printf("MAT文件%s的变量为:\n", file);
		for (i=0; i < ndir; i++)
		{
			printf("%s\n", dir[i]);
		}
	}
	mxFree(dir);

	if (matClose(pmat) != 0) 
	{
		printf("关闭文件 %s 出错!\n",file);
		return(1);
	}
	
	/*重新打开MATLAB MAT文件*/
	pmat = matOpen(file, "r");
	if (pmat == NULL) 
	{
		printf("打开文件 %s 出错!\n", file);
		return(1);
	}
	
	for (i=0; i < ndir; i++) 
	{
		pa = matGetNextVariableInfo(pmat, &name);
		if (pa == NULL) 
		{
			printf("读取文件 %s 出错!\n", file);
			return(1);
		}
		
		printf("MATLAB 数组 %s 的:\n\t维数为: %d\n", 
								name, mxGetNumberOfDimensions(pa));
		printf(" \t行数x列数为%dx%d\n",
								mxGetM(pa),mxGetN(pa));
		
		mxDestroyArray(pa);
	}
	
	
	if (matClose(pmat) != 0) 
	{
		printf("关闭文件 %s 出错!\n",file);
		return(1);
	}
	printf("文件%s分析完毕!\n",file);
	return(0);
}


int main(int argc, char **argv)
{
	char name[_FILE_NAME_LEN];
	int num=0;
	int nFlag1,nFlag2;
	
	printf("请输入要读取的文件名称(*.mat):");
	scanf("%s",name);
	while((name[num++]!='\0')&&(num<=_FILE_NAME_LEN-1));
	num = num-1;
	if(num>=_FILE_NAME_LEN-5)
	{
		printf("输入的文件名太长!\n");
		return 0;
	}

	nFlag1 = strcmp(name+num-4,".MAT");
	nFlag2 = strcmp(name+num-4,".mat");
	
	if(nFlag1&&nFlag2)
	{
		name[num]='.';
		name[num+1]='M';
		name[num+2]='A';
		name[num+3]='T';
		name[num+4]='\0';
	}
	analyze_matfile(name);
	getchar();
	return 0;
}
