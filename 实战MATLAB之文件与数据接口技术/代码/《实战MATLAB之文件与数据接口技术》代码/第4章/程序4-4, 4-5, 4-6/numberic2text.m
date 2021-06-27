%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 4-5 numberic2text.m
function [out] = numberic2text(fid,in,name)
isclose = 0;
if ischar(fid)
    fid = fopen(fid,'w');
end
if ~isnumeric(in)&&~ischar(in)
    out = 0;
    return;
end
formatstr = getformatstr(class(in));
sizein = size(in);
 
%保存的变量信息：包括名称，类型，维数，各维大小
if nargin==2
    %如果用户没有指定名称，则采用随机的默认名称
    name = strcat('data_', class(in), '_', num2str(ceil(rand(1)*10000000000)));
end
out = 0;
out = out + fprintf(fid,'%s %s\n',name,class(in));
out = out + fprintf(fid,'%d ',ndims(in),size(in));
out = out + fprintf(fid,'\n');
if ischar(in)%方便对字符型数据进行处理
    out = out + fprintf(fid,[formatstr],in(:));
else
    out = out + fprintf(fid,[formatstr ','],in(:));
end
fprintf(fid,'\n');

if isclose
    fclose(fid);
end
