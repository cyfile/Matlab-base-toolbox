/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

/* 程序 9-10 Thread_Receive.c */
#include "SerialPortDataTrans.h"
DWORD WINAPI Thread_Receiving(char *receivePort)
{
    HANDLE hComm;
    DCB portDCB;
    char *ch;
    DWORD nRead,nToRead,dataSize;
    DWORD tTransmitExit;
    int ii;
    ch = (char*)malloc(sizeof(char)*(SIZE_RECEIVING+8));
    nToRead = SIZE_RECEIVING;

/*打开串口*/
    hComm = CreateFile(receivePort, GENERIC_READ | GENERIC_WRITE, 
            0, NULL, OPEN_EXISTING, 0, NULL);
    if (hComm == INVALID_HANDLE_VALUE)
    {
        printf("ERROR! 接收端串口创建失败.\n");
        return 0;
    }
    else
    {
        printf("OK! 接收端串口创建成功.\n");
    }
    if (!PurgeComm(hComm,PURGE_TXCLEAR |PURGE_RXCLEAR)==TRUE)
    {
        printf("ERROR! 接收端串口清空缓存失败.\n");
        return 0;
    }
    else
    {
        printf("OK! 接收端串口清空缓存成功.\n");
    }
    

/*设置串口参数*/
    if (!GetCommState(hComm,&portDCB)==TRUE)//获取串口参数.
    {
        printf("ERROR! 接收端串口参数获取失败.\n");
        return 0;
    }
    else
    {
        printf("OK! 接收端串口参数获取成功.\n");
    }
    portDCB.BaudRate=CBR_4800;  //波特率
    portDCB.ByteSize=8;          //num of data bits
    portDCB.Parity=0;             //0:none
    portDCB.XoffLim=nToRead;     //计数
    if (!SetCommState(hComm, &portDCB)==TRUE) //设置串口参数
    {
        printf("ERROR! 接收端串口参数设置失败.\n");
        return 0;
    }
    else
    {
        printf("OK! 接收端串口参数设置成功.\n");
    }
    

/*接收数据*/
    //首先接收数据量（以byte为单位）
    if (!ReadFile(hComm, &dataSize, sizeof(DWORD), &nRead, NULL)==TRUE)
    {
        printf("ERROR! 接收数据失败.\n");
        return 0;
    }
    printf("数据量为 %d Bytes.\n",dataSize);
    //循环接收数据
    for(ii=0; ii<ceil(((float)dataSize+sizeof(END_MARKER))/nToRead); ii++)
    {
        memset(ch,'\0',SIZE_RECEIVING+8);
        if (!ReadFile(hComm, ch, nToRead, &nRead, NULL)==TRUE)
        {
            printf("ERROR! 接收数据失败.\n");
            return 0;
        }
        else
        {
            printf("OK! 接收数据成功.\n");
        }
        printf("接收到的数据为:\n%s\n",ch);
    }
    
/*关闭串口，释放内存，退出线程*/
    if (!CloseHandle(hComm)==TRUE)
    {
        printf("ERROR! 接收端串口关闭失败.\n");
        return 0;
    }
    else
    {
        printf("OK! 接收端串口关闭成功.\n");
    }
    if(ch) free(ch);
    return 1;
}
