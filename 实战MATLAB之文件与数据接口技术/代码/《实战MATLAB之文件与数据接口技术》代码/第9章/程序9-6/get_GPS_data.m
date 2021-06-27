%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 9-6 get_GPS_data.m
function get_GPS_data(comName)
if nargin<1 || nargin >1
    disp('输入参数个数有误');
    return;
end
sCom = serial(comName);
sCom.BaudRate = 4800;           %波特率
sCom.InputBufferSize = 8192;  %接收缓存大小，单位字节
sCom.Timeout = 5;               %等待时间，超过此值则跳出接收，单位秒
% sCom.Parameters = Value;    %设置其它串口参数
% ...

try
    fopen(sCom);         %如果该端口不存在，则报错，并由catch命令捕捉
catch
    disp('创建串口失败');
    return;
end
disp('创建串口成功');
 
gpsfilename= strcat('GPS_', datestr(now),'.txt'); 
                                                  %使用系统时间定义文件名
gpsfilename(gpsfilename==':')='-';
fp = fopen(gpsfilename,'w');
if fp==-1
    disp('待写入文件不存在');
    return;
end
 
ii=1;
while ii<100
    dataR = [];
    [dataR,count,msg] = fgets(sCom);
    if isempty(msg)==0        %若msg不为空，则获取数据失败，
                         %表示在Timeout的时间内串口未传送数据，跳出循环
        disp('获取数据失败');
        break;
    end
    disp(dataR);
    fprintf(fp,dataR);
    ii=ii+1;
end

fclose(fp);                   %关闭数据保存的文件
fclose(sCom);                %关闭串口
delete(sCom);
clear sCom;
end                        % end of function file
