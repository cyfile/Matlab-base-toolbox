%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 10-10 closefigure.m
function closefigure(obj,event)
ud = get(obj,'UserData');
%关闭和释放网络资源
if isfield(ud,'u')
    fclose(ud.u);
    delete(ud.u);
end
delete(obj);
end
