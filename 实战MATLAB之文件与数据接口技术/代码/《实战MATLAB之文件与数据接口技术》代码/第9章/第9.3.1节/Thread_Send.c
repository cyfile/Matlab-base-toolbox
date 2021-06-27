/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

/* 程序 9-9 Thread_Send.c */
#include "SerialPortDataTrans.h"
DWORD WINAPI Thread_Sending(char* sendPort)
{
    HANDLE hComm;
    DCB portDCB;
    DWORD nToWrite,nWritten,fileSize;
    char *ch = NULL;
    char *strBuffer = NULL;
    FILE *fp = NULL; 
    int nb,ne;
    int ii;
    printf("线程1创建成功.\n");
    nToWrite = SIZE_SENDING;

/*打开串口*/
    hComm = CreateFile(sendPort, GENERIC_READ | GENERIC_WRITE, 
            0, NULL,OPEN_EXISTING, 0, NULL);
    if (hComm == INVALID_HANDLE_VALUE)
    {
        printf("ERROR! 发送端串口创建失败.\n");
        return 0;
    }
    else
    {
        printf("OK! 发送端串口创建成功.\n");
    }
    if(!PurgeComm(hComm,PURGE_TXCLEAR | PURGE_RXCLEAR)==TRUE)
    {
        printf("ERROR! 发送端清空缓存失败.\n");
        return 0;
    }
    else
    {
        printf("OK! 发送端清空缓存成功.\n");
    }
    
/*设置串口参数*/
    if (!GetCommState(hComm,&portDCB)==TRUE)//获取串口参数.
    {
        printf("ERROR! 发送端串口参数获取失败.\n");
        return 0;
    }
    else
    {
        printf("OK! 发送端串口参数获取成功.\n");
    }
    portDCB.BaudRate = CBR_4800;             //传送数据的波特率
    portDCB.ByteSize = 8;                     //num of data bits
    portDCB.Parity = 0;                        //0:none
    portDCB.XoffLim = SIZE_SENDING;          //计数
    if (!SetCommState(hComm, &portDCB)==TRUE) //设置串口参数
    {
        printf("ERROR! 发送端串口参数设置失败.\n");
        return 0;
    }
    else
    {
        printf("OK! 发送端串口参数设置成功.\n");
    }
    

/*读取发送文件中的数据至strBuffer，并在末尾添加“$END”标志*/
    g_file_name = (char*)mxCalloc(255,sizeof(char));
    strcpy(g_file_name,"test.txt");
    fp = fopen(g_file_name,"rb");
    if (fp==NULL)
    {
        printf("待发送的文件不存在.\n");
        return 0;
    }
    fseek(fp,0,SEEK_SET);
    nb = ftell(fp);
    fseek(fp,0,SEEK_END);
    ne = ftell(fp);
    fseek(fp,0,SEEK_SET);
    fileSize = ne-nb;
    strBuffer = (char*)malloc((fileSize+sizeof(END_MARKER))*sizeof(char));
    memset(strBuffer, 0x00, (fileSize+sizeof(END_MARKER))*sizeof(char));
    fread(strBuffer,sizeof(char),fileSize,fp);
    strncpy(strBuffer+fileSize,END_MARKER,sizeof(END_MARKER));

/*开始发送文件*/
    //首先发送数据量
    if (!WriteFile(hComm,&fileSize,sizeof(DWORD), &nWritten, NULL)==TRUE)
    {
        printf("数据包发送失败.\n");
        return 0;
    }
    //循环发送数据
    for(ii = 0; ii<(fileSize+sizeof(END_MARKER))/nToWrite;ii++ )
    {
        ch = strBuffer + ii*nToWrite;
        if (!WriteFile(hComm,ch,nToWrite, &nWritten, NULL)==TRUE)
        {
            printf("数据包发送失败.\n");
            return 0;
        }
    }
    if( (ii = (fileSize+sizeof(END_MARKER)) % nToWrite) > 0)
    {
        printf("发送包大小不能整除数据包.\n");
        ch = strBuffer + (fileSize+sizeof(END_MARKER))-ii;
        if (!WriteFile(hComm,ch,ii, &nWritten, NULL)==TRUE)
        {
            printf("数据包发送失败.\n");
            return 0;
        }
    }

/*发送完毕，关闭串口，退出线程*/
    if (!CloseHandle(hComm)==TRUE) //关闭串口
    {
        printf("发送端串口关闭失败.\n");
        return 0;
    }
    else
    {
        printf("发送端串口关闭成功.\n");
    }
    if(strBuffer) free(strBuffer);
    if(fp) fclose(fp);
    if(ch) free(ch);

    return 1;
}
