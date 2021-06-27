%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 2-15 teststruct.m
%保存为teststruct.m文件
function []=teststruct()
%function []=teststruct()
%构造个人通讯录结构体
%个人情况
%              姓名 name
%              地址 addr
%              联系电话 phone
%              爱好 hobby

info(1).name='李芳';
info(1).addr = '南京市南京大学数学系3#335';
info(1).phone = '02552528888'
info(1).hobby = {'旅游','音乐','书法'};

info(2).name='欧阳';
info(2).addr = '哈尔滨市哈尔滨工业大学计算机系99-335';
info(2).phone = '045182589666'
info(2).hobby = {'篮球','游泳','游戏'};

disp(info(1));
disp(info(2));

%删除域
info = rmfield(info,'hobby');

disp(info(1));
disp(info(2));
