%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function TriggerRepeatPropertyEg()
% 说明TriggerRepeat属性的实例
ai = analoginput('winsound');
addchannel(ai,1);
set(ai,'TriggerRepeat',4);
set(ai,'TriggerFcn',@myCallBack);
start(ai);
pause(6);
disp(strcat('triggers executed : ',num2str(ai.TriggersExecuted)));
stop (ai);
delete(ai);
clear ai;

end

function myCallBack(obj,event)
disp('trigger occurs');
% !time /t
end
