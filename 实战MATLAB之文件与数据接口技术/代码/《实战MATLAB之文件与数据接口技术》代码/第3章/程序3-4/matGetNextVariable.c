/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

/* 程序 3-4 matGetNextVariable.c */
/*matGetNextVariable.c文件内容*/
#include "mex.h"
#include "mat.h"
int listvariabledims(const char * file) 
{
	MATFile *pmat;	
	const char * name=NULL;	
	int	  i;	
	mxArray * pa = NULL;
	mwSize ndim;
	mwSize * dim;
    
	/*打开MAT文件*/
	pmat = matOpen(file, "r");
	if (pmat == NULL) 
    {
        mexPrintf("打开文件:%s出错!\n", file);
        return(1);
    }
 	mexPrintf("MAT文件 %s中的变量及信息如下:\n", file);
    /*得到MAT文件中的各个变量*/
	pa = matGetNextVariable(pmat, &name);
    while(pa!=NULL)
    {
        mexPrintf("变量%s  ",name);
        dim = mxGetDimensions(pa);
        ndim = mxGetNumberOfDimensions(pa);
        mexPrintf("维度信息：");
        for(i=0;i<ndim-1;i++)
        {
            mexPrintf("%dx", dim[i]);
        }
        mexPrintf("%d\n", dim[i]);
        mxDestroyArray(pa);
        pa = matGetNextVariable(pmat,&name);
    }
    
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
            listvariabledims(buff);
        }
        else
        {
            mexPrintf("输入的第%d个变量不是字符类型阵列!\n");
        }
    }
	mxFree(buff);
}
