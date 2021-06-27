%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 11-7 demoai_continuous_timer_callback.m
function demoai_continuous_timer_callback(obj,event,plotHandle,titleHandle)
persistent count;
persistent totalData;
if isempty(count)
     count =0;
end
count = count + 1;
[data,time] =getdata(obj,obj.SamplesAvailable);
% 获取数据，并附加在变量totalData后
if isempty(totalData)
    totalData.time = time;
    totalData.data =data;
else
    totalData.time = [totalData.time;time];
    totalData.data = [totalData.data;data];
end
% 调用demoai_continuous_fft函数，检验是否满足条件
if(demoai_continuous_fft(data,plotHandle))
    set(obj,'UserData',totalData);
    stop(obj); 
end
% 实时修改图像句柄的标题
set(titleHandle,'String',['实时信号FFT,回调函数执行次数:', num2str(count)]);
end
