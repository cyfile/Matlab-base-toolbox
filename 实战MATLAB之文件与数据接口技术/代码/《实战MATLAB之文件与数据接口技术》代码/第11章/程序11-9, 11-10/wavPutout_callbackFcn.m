%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%程序 11-10 wavPutout_callbackFcn.m
function wavPutout_callbackFcn(obj,event,plotHandle,y)
startindex = 1;
increment = 500;
while isrunning(obj) % 实时绘制音频波形
    while (obj.SamplesOutput < startindex + increment -1), end
    try
        x = obj.SamplesOutput;
        set(plotHandle, 'ydata',y(x:x+increment-1));
        set(gca, 'YLim', [-0.8 0.8], 'XLim',[1 increment])
        drawnow;
        startindex =  startindex+increment;
    end
end
stop(obj);
delete(obj);
end
