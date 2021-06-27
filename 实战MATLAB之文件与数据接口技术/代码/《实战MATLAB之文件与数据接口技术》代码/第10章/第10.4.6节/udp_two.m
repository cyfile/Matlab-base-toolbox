%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 10-6 udp_two.m
function [] = udp_two(flag)
%flag = 'send','recv'
echoudp('off');
hd = dialog('WindowStyle', 'normal', 'Name', 'UDP双节点通信');%创建对话框
set(hd,'position',[199   377   247   135]);
if isequal(flag,'send')
    %启动发送端，首先创建两个按钮	
    uicontrol(hd,'string','开始发送','position',[30 30 80 100],...
        'callback',@startcallback);
    uicontrol(hd,'string','结束发送','position',[130 30 80 100],...
        'callback',@stopcallback);
    %初始化udp对象
    u = udp('192.168.123.241', 'RemotePort', 4012, 'LocalPort', 4012);
    ud.u = u;
    ud.data = 0;
    %设置用户数据
    set(u,'UserData',ud);
else
    %当输入flag非'send'时，启动接收端
    %创建udp对象
    u = udp('192.168.123.122', 'RemotePort', 4012, 'LocalPort', 4012);
    uicontrol(hd,'style','text','string','Recv Data...',...
        'position',[30 30 170 100]);
    set(u,'DatagramReceivedFcn',@recvcallback);
    %设置用户数据
    ud.data = 0;
    ud.nsend = 10;
    ud.u = u;
    ud.bytes = 0;
    set(hd,'UserData',ud);
    set(u,'UserData',ud);
    set(u,'DatagramTerminateMode','on');
    %打开udp网口
    fopen(u);
end
set(hd,'UserData',ud,'CloseRequestFcn',@closefigure);
end