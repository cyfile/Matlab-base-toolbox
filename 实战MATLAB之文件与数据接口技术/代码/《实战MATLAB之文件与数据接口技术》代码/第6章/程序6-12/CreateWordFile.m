%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 6-12 CreateWordFile.m
% CreateWordFile.m
% 利用MATLAB生成Word文档
%%
try     % 如果Word服务器已打开，则返回句柄
    myWord = actxGetRunningServer('Word.Application');
catch   % 否则创建Word服务器，并返回句柄
    myWord = actxserver('Word.Application'); 
end
set(myWord,'Visible',1);      % 设置Word服务器可见
myDoc = myWord.Document.Add;  % 新建空白文档

%% Content接口操作
myContent = myDoc.Content;    % 返回文档的Content接口的句柄
myContent.Start = 0;          % 设置文档Content的起始位置
title = 'MATLAB 简介';         % 内容
myContent.text = title;       % 写入文档的内容
myContent.Font.Size = 20;     % 设置字号
myContent.ParagraphFormat.Alignment = 'wdAlignParagraphCenter';
                                   % 居中对齐

%% Selection接口操作
mySelection = myWord.Selection; 
mySelection.Start = myContent.end;  % 设置选定区域的起始位置为文档内容的末尾
% 添加脚注
FootnoteStr = '注：本文内容主要来自维基百科。';
mySelection.Footnotes.Add (mySelection.Range, '',FootnoteStr);
mySelection.Start = myContent.end;  % 设置选定区域的起始位置为文档内容的末尾
mySelection.TypeParagraph;          % 回车，另起一段
% 添加第一段文字
% 文字的格式设置
mySelection.Font.Name = '宋体';     % 设置字体
mySelection.Font.Size = 12;         % 设置字号
mySelection.Font.Bold = 0;          % 字体不加粗
mySelection.paragraphformat.Alignment = 'wdAlignParagraphLeft'; 
                                          % 居左对齐
mySelection.paragraphformat.LineSpacingRule = 'wdLineSpace1pt5'; 
                                          % 行距为1.5倍行距
mySelection.paragraphformat.FirstLineIndent = 25;  % 首行缩进磅数
% 添加段落内容
myStr1 = ['MATLAB是Matrix Laboratory的缩写，是一款由'...
    '美国MathWorks公司出品的商业数学软件。MATLAB是一种用于算法开发、'...
    '数据可视化、数据分析以及数值计算的高级技术计算语言和交互式环境'...
    '除了矩阵运算、绘制函数/数据图像等常用功能外，MATLAB还可以用来创建'...
    '用户界面及调用其它语言（包括C，C++和FORTRAN）编写的程序。']; 
                                         % 第1自然段的内容
mySelection.Text = myStr1;          % 在选定区域输入文字内容
mySelection.Start = mySelection.end;
mySelection.TypeParagraph;          % 回车，另起一段

% 添加图片及其说明
% 设置图片的格式
mySelection.paragraphformat.Alignment = 'wdAlignParagraphCenter'; 
                                                          % 居中对齐
mySelection.paragraphformat.FirstLineIndent = 0; % 首行缩进磅数
% 添加图片 MATLAB_logo.jpg
myImg1 = [pwd '\MATLAB_logo.jpg'];
mySelection.InlineShapes.AddPicture(myImg1);
mySelection.Start = mySelection.end;
mySelection.TypeParagraph;          % 回车
% 添加图片的说明
mySelection.Font.Size = 10;         % 设置字号
mySelection.Font.Name = '黑体';     % 设置字体
myFigStr1 = '图1 MATLAB logo的变化历程';
mySelection.Text = myFigStr1;          % 在选定区域输入文字内容
mySelection.Start = mySelection.end;
mySelection.TypeParagraph;          % 回车

% 添加第二段文字
% 文字的格式设置
mySelection.Font.Name = '宋体';     % 设置字体
mySelection.Font.Size = 12;         % 设置字号
mySelection.Font.Bold = 0;          % 字体不加粗
mySelection.paragraphformat.Alignment = 'wdAlignParagraphLeft'; 
                                                           % 居左对齐
mySelection.paragraphformat.LineSpacingRule = 'wdLineSpace1pt5'; 
                                                           % 行距为1.5倍行距
mySelection.paragraphformat.FirstLineIndent = 25; % 首行缩进磅数
% 添加段落内容
myStr2 = ['尽管MATLAB主要用于数值运算，但利用为数众多的附加工具箱'...
    '（Toolbox）它也适合不同领域的应用，例如控制系统设计与分析、'...
    '图像处理、信号处理与通讯、金融建模和分析等。另外还有一个'...
    '配套软件包Simulink，提供了一个可视化开发环境，常用于系统模拟、'...
    '动态/嵌入式系统开发等方面。'];         % 第2自然段的内容
mySelection.Text = myStr2;          % 在选定区域输入文字内容
mySelection.Start = mySelection.end;
mySelection.TypeParagraph;          % 回车
% 添加段落内容
myStr3 = ['MATLAB的早期版本如下表所示。'];         % 第2自然段的内容
mySelection.Text = myStr3;          % 在选定区域输入文字内容
mySelection.Start = mySelection.end;
mySelection.TypeParagraph;          % 回车
% 添加表格的标题
mySelection.paragraphformat.Alignment = 'wdAlignParagraphCenter'; 
                                          % 对齐方式
mySelection.Font.Size = 10;         % 设置字号
mySelection.Font.Name = '黑体';     % 设置字体
myTableStr1 = '表1 MATLAB的版本';
mySelection.Text = myTableStr1;     % 在选定区域输入文字内容
mySelection.Start = mySelection.end;
mySelection.TypeParagraph;          % 回车
% 表格文字格式
mySelection.Font.Size = 12;         % 设置字号
mySelection.Font.Name = '宋体';     % 设置字体

%% Tables接口（表格）
nRow = 8;   % 行数
nColumn = 3;% 列数
myTable = mySelection.Tables.Add(mySelection.Range,nRow,nColumn);
myTable.Borders.InsideLineStyle = 'wdLineStyleSingle'; % 内边框样式
myTable.Borders.InsideLineWidth = 'wdLineWidth025pt'; % 内边框宽度
myTable.Borders.OutsideLineStyle = 'wdLineStyleSingle'; % 外边框样式
myTable.Borders.OutsideLineWidth = 'wdLineWidth150pt'; % 外边框宽度
myTable.Rows.Alignment = 'wdAlignRowCenter';% 设置表格整体居中
% 设置各单元格的对齐方式
for jj = 1:nColumn
    myTable.Cell(1,jj).Range.Paragraphs.Alignment = ...
           'wdAlignParagraphCenter';  % 标题行居中对齐
end
for ii = 2:nRow
    for jj = 1:nColumn
        myTable.Cell(ii,jj).Range.Paragraphs.Alignment = ...
           'wdAlignParagraphLeft'; % 内容行居左对齐
    end
end
% 设置单元格宽度
myTable.Columns.Item(1).Width = 140;
for ii = 2 : myTable.Columns.Count
    myTable.Columns.Item(ii).Width = 120;
end
% 合并单元格
myTable.Cell(5,3).Merge(myTable.Cell(6,3));
myTable.Cell(7,3).Merge(myTable.Cell(8,3));
% 添加内容
myTable.Cell(1,1).Range.Text = '版本';
myTable.Cell(1,2).Range.Text = '释放编号';
myTable.Cell(1,3).Range.Text = '年份';
myTable.Cell(2,1).Range.Text = 'MATLAB 1.0';
myTable.Cell(2,2).Range.Text = 'R?';
myTable.Cell(2,3).Range.Text = '1984';
myTable.Cell(3,1).Range.Text = 'MATLAB 2';
myTable.Cell(3,2).Range.Text = 'R?';
myTable.Cell(3,3).Range.Text = '1986';
myTable.Cell(4,1).Range.Text = '……';
myTable.Cell(4,2).Range.Text = '……';
myTable.Cell(4,3).Range.Text = '……';
myTable.Cell(5,1).Range.Text = 'MATLAB 7.8';
myTable.Cell(5,2).Range.Text = 'R2009a';
myTable.Cell(5,3).Range.Text = '2009';
myTable.Cell(6,1).Range.Text = 'MATLAB 7.9';
myTable.Cell(6,2).Range.Text = 'R2009b';
myTable.Cell(7,1).Range.Text = 'MATLAB 7.10';
myTable.Cell(7,2).Range.Text = 'R2010a';
myTable.Cell(7,3).Range.Text = '2010';
myTable.Cell(8,1).Range.Text = 'MATLAB 7.11';
myTable.Cell(8,2).Range.Text = 'R2010b';

%% Save Doc File
FilenameAndPath = [pwd '\mydoc1']; % 文档另存路径和文件名
myDoc.SaveAs(FilenameAndPath);     % 另存为当前文档
myDoc.Close;                       % 关闭Word文档
myWord.Quit;                       % 退出Word服务器

%% end of code
