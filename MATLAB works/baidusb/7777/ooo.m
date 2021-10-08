% timerbusymode
function aaa
timerA=timer('startfcn',@startAfcn,...
    'errorfcn',@errorAfcn,...
    'timerfcn',@timerAfcn,...
    'stopfcn',@stopAfcn,...
    'startdelay',.5,...
    'executionmode','fixedrate',...
    'period',.5,...
    'taskstoexecute',3,...
    'busymode','error');
%     'busymode','queue');
%     'busymode','drop');


set(timerA,'userdata',clock);
start(timerA)
end
function startAfcn(obj,evn)
disp(['start time:',dispnow(obj)])
end
function timerAfcn(obj,evn)
disp(['execution time:',dispnow(obj)])
pause(.8)
disp(['execution end time:',dispnow(obj)])
end
function stopAfcn(obj,evn)
disp(['stop time:',dispnow(obj)])
end
function errorAfcn(obj,evn)
disp(['error time:',dispnow(obj)])
end
function esl=dispnow(obj)
t=clock;
et=etime(t,get(obj,'userdata'));
esl=num2str(et);
end