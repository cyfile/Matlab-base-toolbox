/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

/* 程序 3-3 matGetDir.c */
/*matGetDir.c文件内容*/
#include "mex.h"
#include "mat.h"

int listvariable(const char * file) 
{
	MATFile *pmat;
	const char **dir;
	const char *name;
	int	  ndir;
	int	  i;	

	/*打开MAT文件*/
	pmat = matOpen(file, "r");
	if (pmat == NULL) 
    {
        mexPrintf("打开文件:%s出错!\n", file);
        return(1);
    }

	/*   得到MAT变量的目录列表  */
	dir = (const char **)matGetDir(pmat, &ndir);
	if (dir == NULL) 
    {
        mexPrintf("读取文件 %s的变量列表出错!\n", file);
        return(1);
    }
	else 
    {
        mexPrintf("MAT文件 %s中的变量如下:\n", file);
        for (i=0; i < ndir; i++)
        {
            mexPrintf("%s\n",dir[i]);
        }
    }
    mxFree(dir);

    /* 关闭MAT文件. */
    if (matClose(pmat) != 0) 
    {
        mexPrintf("关闭文件 %s 出错!\n",file);
        return(1);
    }  
    return(0);
}

void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[])
{
  	int i=0;
	char * buff=NULL;
	buff = mxCalloc(200,sizeof(char));
	for(i=0;i<nrhs;i++)
    {
        if(mxIsChar(prhs[0]))
        {					
            mxGetString(prhs[i], buff, 200);					
            listvariable(buff);
        }
        else
        {
            mexPrintf("输入的第%d个变量不是字符类型阵列!\n");
        }
    }	
	mxFree(buff);
}
