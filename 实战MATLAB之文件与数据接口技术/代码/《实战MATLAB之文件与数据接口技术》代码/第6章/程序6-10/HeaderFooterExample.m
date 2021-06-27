%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 6-10 HeaderFooterExample.m
% HeaderFooter Object
try     % 如果Word服务器已打开，则返回句柄
    myWord = actxGetRunningServer('Word.Application');
catch   % 否则创建Word服务器，并返回句柄
    myWord = actxserver('Word.Application'); 
end
set(myWord,'Visible',1);      % 设置Word服务器可见
myDoc = myWord.Document.Add;  % 新建空白文档
mySection = myDoc.Sections.Item(1); % 返回第一节的Section对象
myFooter = mySection.Footers(1).Item(1); % 返回页脚
myFooter.Range.text = 'Footer Test'; % 设置页脚内容
