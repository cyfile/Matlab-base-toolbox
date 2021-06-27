%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 10-7 startcallback.m
function startcallback(obj,event)
hd = get(obj,'parent');
ud = get(hd,'UserData');
fclose(ud.u);
set(ud.u,'TimerFcn',@senddata,'TimerPeriod',1.0);
fopen(ud.u);
end
