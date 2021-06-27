%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序9-1 serial_testReadAsyncMode2.m
s=serial('COM2');
fopen(s);
tic
for ii=1:3000
    if(isequal(s.TransferStatus,'write'))
    else
        fprintf(s,'test');
    end
    pause(0.01);
end
toc;
fclose(s);
delete(s);
clear s; % end of code
