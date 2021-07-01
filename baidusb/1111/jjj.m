% 论坛统计(二)
function testtimer(task_num)
%
if nargin<1
    task_num=5;
end

%%
t = timer;
t.StartFcn = @(~,thisEvent)disp(['timer started at '...
    datestr(thisEvent.Data.time,'dd-mmm-yyyy HH:MM:SS.FFF')]);
t.TimerFcn = @rceroddata;
t.StopFcn = @stopnotify;
%t.Period = 3;
t.TasksToExecute = task_num;
t.ExecutionMode = 'fixedRate';
t.StartDelay = 5;
start(t);

    function stopnotify(tobj,tevent)
        tim_stop=datestr(tevent.Data.time,'dd HH:MM:SS');
        evalin('base',['timerstop=''',tim_stop,''';']);
        tim_count=num2str(tobj.tasksexecute);
        evalin('base',['timercount=''',tim_count,' 次'';']);
       
        drawnow
    end

    function rceroddata(tobj,tevent)
        disp(tobj.tasksexecute)
        n=10*tobj.tasksexecute;
        forumstatistic(n-9:n);
    end

end