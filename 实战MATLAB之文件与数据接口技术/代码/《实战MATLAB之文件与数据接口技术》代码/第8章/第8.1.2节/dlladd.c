/*************************************************/
/* 《实战MATLAB之文件与数据接口技术》附加程序    */
/* 作  者：江泽林 刘维                           */
/* 出版社：北京航空航天大学出版社                */
/*************************************************/

/* dlladd.c */
/*dlladd.c文件*/
#include "dlladd.h"
DLLEXPORT double addDoubleS(double v1,double v2)
{
    return (v1+v2);
}
DLLEXPORT void addDoubleV(double * v1,const double * v2, int size)
{
    int kk;
    for(kk=0;kk<size;kk++)
    {
        v1[kk] = v1[kk]+v2[kk];
    }
}

