%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 6-1 findMaxMin.m
function [Data] = findMaxMin(Data)
DataTemp = Data.Value;
Count=Data.Count;
Data.Value = cell(1,2);
Data.Value{1} = DataTemp{1};   %max value
Data.Value{2} = DataTemp{1};   %min value
for k=1:Count
    v = DataTemp{k};
    if v>Data.Value{1}
        Data.Value{1} = v;
    end
    if v<Data.Value{2}
        Data.Value{2} = v;
    end
end  %end of findMaxMin.m
