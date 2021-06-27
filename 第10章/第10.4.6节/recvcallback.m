%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 10-9 recvcallback.m
function recvcallback(obj,event)
ud = get(obj,'UserData');
BytesAvailable = get(obj,'BytesAvailable');
ud.bytes = ud.bytes + BytesAvailable;
data = fread(obj,BytesAvailable/4,'int32');
fprintf(1,'本次收到数据为"%3.2f", 共读取字节数:%d，本次读取字节数:%d\n',data,ud.bytes,BytesAvailable);
set(obj,'UserData',ud);
end
