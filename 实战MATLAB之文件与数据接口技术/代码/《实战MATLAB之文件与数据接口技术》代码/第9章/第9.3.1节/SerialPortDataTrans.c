/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

/* 程序 9-8 SerialPortDataTrans.c */
#include "SerialPortDataTrans.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    char *s_portName;
    char *r_portName;
    HANDLE * g_pThread;
    s_portName = (char*)mxCalloc(5,sizeof(char));
    r_portName = (char*)mxCalloc(5,sizeof(char));
    mxGetString(prhs[0],s_portName,5);
    mxGetString(prhs[1],r_portName,5);

    g_pThread=(HANDLE*)malloc(2*sizeof(HANDLE));
    g_pThread[0] = (HANDLE)CreateThread(NULL,0, Thread_Sending, s_portName, 0, NULL);
    g_pThread[1] = (HANDLE)CreateThread( NULL, 0, Thread_Receiving, r_portName, 0, NULL);
    WaitForMultipleObjects(2,g_pThread,TRUE,INFINITE);
    printf("两个线程均结束.\n");
    mxFree(s_portName);
    mxFree(r_portName);
    free(g_pThread);
}
