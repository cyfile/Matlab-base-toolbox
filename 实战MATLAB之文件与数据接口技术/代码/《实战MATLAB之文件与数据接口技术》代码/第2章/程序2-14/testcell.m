%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 2-14 testcell.m
%保存为testcell.m文件
function []=testcell()
%function []=testcell()
%testcell.m
tcell = cell(2,3);
tcell{1,1} = [1 2 3;4 5 6;7 8 9;];
%... 表示续行符号
tcell{1,2} = struct('name','李月',...
        'college','北京科技大学',...
        'phone','01063320501',...
        'specialties',{'平面设计', '网站制作'});
tcell{1,3}=[2+3*i 5+6*i;3+3*i 0.1+0.558*i;];
tempcell=cell(2,2);
tempcell{1,1}='string';
tempcell{1,2}=[2 4;6 8;];
tempcell{2,1}=[7 8 9];
tempcell{2,2}=32+i;
tcell{2,1}=tempcell;
tcell{2,2}='Hello World!';
tcell{2,3}=[9 8 6;5 4 3;2 1 7;];
 
%采用{和}索引得到相应元组阵列元素
for ii=1:2
    for jj=1:3
        disp(tcell{ii,jj})
    end
end
%通过(和)索引得到1x1的相应元组阵列
for ii=1:2
    for jj=1:3
        disp(tcell(ii,jj))
    end
end
