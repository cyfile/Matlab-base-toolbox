%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 6-9 ShapeExample.m
try     % 如果Word服务器已打开，则返回句柄
    myWord = actxGetRunningServer('Word.Application');
catch   % 否则创建Word服务器，并返回句柄
    myWord = actxserver('Word.Application'); 
end
set(myWord,'Visible',1);      % 设置Word服务器可见
myDoc = myWord.Document.Add;  % 新建空白文档
type = 34;  % 类型为左箭头
left = 100; % 距左边缘的距离（磅数）
top = 100;  % 距上边缘的距离（磅数）
width = 100; % 宽度（磅数）
height = 50;% 高度（磅数）
myShape = myDoc.Shapes.AddShape(type,left,top,width,height);
