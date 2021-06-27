%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 6-6 testCopyAndPaste.m
try     % 如果Word服务器已打开，则返回其句柄
    myWord = actxGetRunningServer('Word.Application');
catch   % ?否则创建Word服务器，并返回句柄
    myWord = actxserver('Word.Application'); 
end
set(myWord,'Visible',1);      % 设置Word服务器可见
myDoc1 = myWord.Document.Add;  % 添加空白文档1
myDoc1.ActiveWindow.Selection.Text = 'This is an example of pasting the content.';
myDoc1.ActiveWindow.Selection.Copy;  % 拷贝文档1的内容
myDoc2 = myWord.Document.Add;  % 添加空白文档2
myDoc2.ActiveWindow.Selection.Paste; % 在文档2中粘贴
