%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 4-10 getTableDataEg.m
clear;
clc;
filename = 't20111026_402761639.htm';
[pathstr, name, ext] = fileparts(filename);
xlsfilename = fullfile(pathstr,strcat(name,'.xls'));

txt = fileread(filename);
tables = regexpi(txt, '<table.*?>(.*?)</table>', 'tokens');
for ii = 1:length(tables)
    table = tables{ii}{1};
    rows = regexpi(table, '<tr.*?>(.*?)</tr>', 'tokens');
    for jj = 1:length(rows)
        row = rows{jj}{1};
        row=regexprep(row, '&nbsp;',' ');
                                        %替代html代码中的&nbsp;为空格
        headers = regexpi(row, '<th.*?>(.*?)</th>', 'tokens');
        if ~isempty(headers)  % 判断标题行是否存在
            for kk = 1:length(headers)
                header=regexprep(headers{kk}{1},'<.*?>','');  %去除标签
                data{jj,kk} = header;
            end
            continue
        end
        columns = regexpi(row, '<td.*?>(.*?)</td>', 'tokens');
        for kk = 1:length(columns)
            column = regexprep(columns{kk}{1}, '<.*?>', '');   %去除标签
            data{jj,kk} = column;
        end
    end
%     disp(data);
    xlswrite(xlsfilename,data,strcat('sheet',num2str(ii)));
    clear data;
end
