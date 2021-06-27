/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

#include "SerialDLL.h"
DLLEXPORT int ReadData(char * receivePort)
{
    HANDLE hComm;
    DCB portDCB;
    char *ch;
    DWORD nRead,nToRead;
    int ii;
    FILE* fw = fopen("RcvFile.txt","w");

    ch = (char*)malloc(sizeof(char)*(RECEIVING_BLOCK_SIZE+8));
    nToRead = RECEIVING_BLOCK_SIZE;

    /*打开串口*/
    hComm = CreateFile(receivePort, GENERIC_READ | GENERIC_WRITE, 
		0, NULL, OPEN_EXISTING, 0, NULL);
    if (hComm == INVALID_HANDLE_VALUE)
    {
        printf("ERROR! 接收端串口创建失败.\n");
        return -1;
    }
    else
    {
        printf("OK! 接收端串口创建成功.\n");
    }
    if (!PurgeComm(hComm,PURGE_TXCLEAR |PURGE_RXCLEAR)==TRUE)
    {
        printf("ERROR! 接收端串口清空缓存失败.\n");
        return -2;
    }
    else
    {
        printf("OK! 接收端串口清空缓存成功.\n");
    }

    /*设置串口参数*/
    if (!GetCommState(hComm,&portDCB)==TRUE)/*获取串口参数*/
    {
        printf("ERROR! 接收端串口参数获取失败.\n");
        return -3;
    }
    else
    {
        printf("OK! 接收端串口参数获取成功.\n");
    }
    portDCB.BaudRate=CBR_4800;  /*波特率*/
    portDCB.ByteSize=8;          /*num of data bits*/
    portDCB.Parity=0;             /*0:none*/
    portDCB.XoffLim=nToRead;     /*计数*/
    if (!SetCommState(hComm, &portDCB)==TRUE) /*设置串口参数*/
    {
        printf("ERROR! 接收端串口参数设置失败.\n");
        return -4;
    }
    else
    {
        printf("OK! 接收端串口参数设置成功.\n");
    }

    /*接收数据*/
    /*循环接收数据*/
    for(ii=0; ii<RECEIVING_BLOCK_NUM; ii++)
    {
        memset(ch,'\0',RECEIVING_BLOCK_SIZE+8);
        if (!ReadFile(hComm, ch, nToRead, &nRead, NULL)==TRUE)
        {
            printf("ERROR! 接收数据失败.\n");
            return -5;
        }
        else
        {
            printf("OK! 接收数据成功.\n");
        }
        fprintf(fw,"%s\n",ch);
    }
    
    /*关闭串口，释放内存，退出线程*/
    if (!CloseHandle(hComm)==TRUE)
    {
        printf("ERROR! 接收端串口关闭失败.\n");
        return -6;
    }
    else
    {
        printf("OK! 接收端串口关闭成功.\n");
    }
    fclose(fw);
    if(ch) free(ch);
    return 1;
}
