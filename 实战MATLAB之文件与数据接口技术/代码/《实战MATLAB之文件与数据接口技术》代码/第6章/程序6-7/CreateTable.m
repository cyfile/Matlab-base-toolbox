%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 6-7 CreateTable.m
%%
try     % 如果Word服务器已打开，则返回其句柄
    myWord = actxGetRunningServer('Word.Application');
catch   % ?否则创建Word服务器并返回句柄
    myWord = actxserver('Word.Application'); 
end
set(myWord,'Visible',1);      % 设置Word服务器可见
myDoc = myWord.Document.Add;  % 添加空白文档
%% Selection接口
mySelection = myWord.Selection; 
mySelection.Start = 0;              % 设置区域起始位置
% 添加表格名称
mySelection.Text = '表1 产品A 2010年季度销售量';
mySelection.paragraphformat.Alignment = 'wdAlignParagraphCenter'; %对齐
mySelection.Start = mySelection.end;
mySelection.TypeParagraph;          % 回车
mySelection.ClearFormatting;        % 清除格式
%% Tables接口
nRow = 5;   % 行数
nColumn = 3;% 列数
myTable=mySelection.Tables.Add(mySelection.Range,nRow,nColumn);
