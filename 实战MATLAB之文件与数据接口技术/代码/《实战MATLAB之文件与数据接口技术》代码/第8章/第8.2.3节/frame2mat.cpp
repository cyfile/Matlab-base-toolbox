/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

#include "stdio.h"
#include "mat.h"
#include "matrix.h"
#define _START_FLAG 0xAAAAAAAA
#define _END_FLAG 0xEEEEEEEE

typedef struct _FRAME_HEAD
{
	unsigned int startv;
	unsigned int frameLen;
	unsigned int type;
}fmHead;

char * GetElementType(unsigned int type)
{
    switch(type)
    {
        case 1:
        {
            return "float";
        }
        case 2:
        {
            return "double";
        }
        case 3:
        {
            return "int16";
        }
        case 4:
        {
            return "int32";
        }
        default:
        {
            return "unknown";
        }
    }
}

int GetElementSize(unsigned int type)
{
    switch(type)
    {
        case 1:
        {
            return sizeof(float);
        }
        case 2:
        {
            return sizeof(double);
        }
        case 3:
        {
            return sizeof(short);
        }
        case 4:
        {
            return sizeof(int);
        }
        default:
        {
            return 1;//默认按字节计算
        }
    }
}

mxClassID GetClassID(unsigned int type)
{
    switch(type)
    {
        case 1:
        {
            return mxSINGLE_CLASS;
        }
        case 2:
        {
            return mxDOUBLE_CLASS;
        }
        case 3:
        {
            return 	mxINT16_CLASS;
        }
        case 4:
        {
            return mxINT32_CLASS;
        }
        default:
        {
            return mxDOUBLE_CLASS;//默认按字节计算
        }
    }
}

//读取数据帧
mxArray * ReadData(FILE * fp)
{
    int ib,ie;
    int fpos;
    int kk;
    unsigned int startv,endv;
    fmHead head;
    double filesize;
    char * fieldnames[5] = {"startv","frameLen","type","data","endv"}; 
    mxArray * pDataArray=NULL;
    mxArray * pOut = NULL;
    void * pData = NULL;
    int datasize;
    
    /*获取文件大小*/
    fseek(fp,0,SEEK_SET);
    ib = ftell(fp);
    fseek(fp,0,SEEK_END);
    ie = ftell(fp);
    filesize = ie - ib;
    
    /*统计数据帧个数*/
    fseek(fp,0,SEEK_SET);
    fpos = ftell(fp);
    kk = 0;
    while(fpos<filesize)
    {
        fread(&startv,sizeof(unsigned int),1,fp);
        if(startv == _START_FLAG)
        {
            fseek(fp,-4,SEEK_CUR);
            fread(&head,sizeof(fmHead),1,fp);                  
            fseek(fp,head.frameLen-sizeof(fmHead)-sizeof(unsigned int),SEEK_CUR);
            fread(&endv,sizeof(unsigned int),1,fp);
            kk = kk + 1;           
        }
        fpos = ftell(fp);
    }
    
     /*创建输出的数据结构体*/
     pOut = mxCreateStructMatrix(kk, 1, 5, (const char **)fieldnames);
     /*读入数据*/
    fseek(fp,0,SEEK_SET);
    fpos = ftell(fp);
    kk = 0;
    while(fpos<filesize)
    {
        fread(&startv,sizeof(unsigned int),1,fp);
        if(startv == _START_FLAG)
        {
            fseek(fp,-4,SEEK_CUR);
            fread(&head,sizeof(fmHead),1,fp);
            mxSetField(pOut,kk,"startv",mxCreateDoubleScalar(head.startv));
            mxSetField(pOut,kk,"frameLen",mxCreateDoubleScalar(head.frameLen));
            mxSetField(pOut,kk,"type",mxCreateDoubleScalar(head.type)); 
            datasize =  head.frameLen-sizeof(fmHead)-sizeof(unsigned int);
            pDataArray = mxCreateNumericMatrix(datasize/GetElementSize(head.type),1,GetClassID(head.type),mxREAL);            
            pData = mxGetData(pDataArray);
            fread(pData,datasize,1,fp);
            mxSetField(pOut,kk,"data",pDataArray);
            fread(&endv,sizeof(unsigned int),1,fp);
            mxSetField(pOut,kk,"endv",mxCreateDoubleScalar(endv));
            kk = kk + 1;           
        }
        fpos = ftell(fp);
    }
    
    return pOut;
}

int main(int argc, char* argv[])
{
	FILE * fp=NULL;	
    mxArray * pStruct;
    MATFile  * pMatFile;
	if(argc<3)
	{
		printf("请输入数据文件名和输出MAT文件名称\n");
		return 1;
	}
	fp =  fopen(argv[1],"rb");
	if(!fp)
	{
		printf("文件打开错误,fp = 0x%x\n",fp);
		return 1;
	}    
    pStruct = ReadData(fp);    
    fclose(fp);
    fp = NULL;
    
    pMatFile = matOpen(argv[2],"w");
    matPutVariable(pMatFile,"framedata",pStruct);    
    matClose(pMatFile);
    
    mxDestroyArray(pStruct);
	return 0;
}

