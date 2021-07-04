% MATLABDesktop backup
matlab.bat startup.m mybackup.m finish.m

`不是运行的


edit matlab.bat
%%%matlab.bat
xcopy /y F:\213\MATLAB\R2012a\toolbox\local\mypreferences\* C:\Users\Administrator\AppData\Roaming\MathWorks\MATLAB\R2012a\
start F:\213\MATLAB\R2012a\bin\matlab.exe
%%%%%


oldpath=pwd;
cd([matlabroot,'\toolbox\local'])


edit startup.m
%%%startup.m
% if exist('mypreferences','dir')
%         copyfile('mypreferences\',prefdir)
% end
cd('F:\matlabdoc')
% userpath(pwd)
display('I am here!')
display('Hi! honney,I love you more than the stars above heaven!')
%%%

edit mybackup.m
%%% mybackup.m
oldpath=pwd;
cd([matlabroot,'\toolbox\local'])
if ~exist('mypreferences','dir')
    mkdir('mypreferences')
end
delete('mypreferences\*')
copyfile(prefdir,'mypreferences')
cd(oldpath)
disp('backup complete!!')
%%%

 

edit finish.m
%%%finish.m
mybackup
display('byebye!')
pause(1)
%%%%%