%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 7-3 StructArrayExample.m
data = cell(4,1);
for kk = 1:length(data(:))
    if mod(kk,2)==0
        data{kk} = int8(ones(3,1)*kk);
    else
        data{kk} = int16(ones(3,1)*kk);
    end
end
genData('sarray.dat',data(:));
mf = memmapfile('sarray.dat','format',{'int16',[1 3],'i16'; 'int8',[1 3],'i8'},'repeat',2);
mf.Data(1)
mf.Data(2)
mf.Writable = true;
mf.Data(2).i16 = int16([6 6 6]);
mf.Data(2).i16
