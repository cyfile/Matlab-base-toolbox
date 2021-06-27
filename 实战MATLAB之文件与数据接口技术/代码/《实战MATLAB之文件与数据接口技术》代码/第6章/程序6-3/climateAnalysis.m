%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 6-3 climateAnalysis.m
%climateAnalysis.m
exl = actxserver('excel.application');
exlWkbk = exl.Workbooks;
exlFile = exlWkbk.Open([pwd '\climate2007.xlsx']);
exlSheet1 = exlFile.Sheets.Item('Sheet1');
robj = exlSheet1.Columns.End(4);  % Find the end of the column
numrows = robj.row;                  % And determine what row it is
dat_range = ['A1:G' num2str(numrows)]; % Read to the last row
rngObj = exlSheet1.Range(dat_range);
exlData = rngObj.Value;
x = cell2mat(exlData(2:end,2)); % mean temperature
y = cell2mat(exlData(2:end,6)); % sunshine amount
figure; hold on;
plot(x,y,'ko');
xlabel('平均气温(℃)');
ylabel('全年日照量(小时)');
xdata = [ones(size(x, 1), 1), x]; 
b = regress(y, xdata);        % linear regression
yreg = xdata*b;
plot(x,yreg,'k');
exlWkbk.Close;
exl.Quit;
exl.delete;
