%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 2-8 showInputSign_if.m
% if语句的使用方法测试，保存为showInputSign_if.m文件
function [] = showInputSign_if (input)
%根据输入数据的正负不同，给出不同的输出
nlen = length(input);
if ~isreal(input) %如果输入为复数，退出程序
    display('输入数据为复型!');
    return;
end
if nlen>1
    disp('输入的数据不是1x1的数值阵列!');   
else
    if input ~= 0 %注意“~=”表示“不等于”
        if input > 0 
            disp('输入数据大于0');    
        else
            disp('输入数据小于0');
        end         
    else
        disp('输入数据等于0');        
    end
end
