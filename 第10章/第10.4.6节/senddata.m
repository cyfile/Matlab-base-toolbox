%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 10-11 senddata.m
function senddata(obj,event)
ud = get(obj,'UserData');
if isfield(ud,'data') && isfield(ud,'u')   
    fwrite(ud.u,ud.data,'int32');
    fprintf(1,'发送数据%d\r',ud.data);
    ud.data = ud.data + 1;    
end
set(obj,'UserData',ud);
end
