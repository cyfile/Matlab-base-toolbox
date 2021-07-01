% MATLAB Mobile timer ≤‚ ‘
function testtimer(task_num)
%
if nargin<1
    task_num=4;
end

tim=zeros(task_num,1);
val=zeros(task_num,1);
%%
t = timer;
t.StartFcn = @(~,thisEvent)disp(['timer started at '...
    datestr(thisEvent.Data.time,'dd-mmm-yyyy HH:MM:SS.FFF')]);
%t.TimerFcn =@(~,~) fun(2);
t.TimerFcn = @rceroddata;
t.StopFcn = @plotdata;
t.Period = 3;
t.TasksToExecute = task_num;
t.ExecutionMode = 'fixedRate';
t.StartDelay = 5;
start(t);
%datetick('x','MM:SS')
    function plotdata(tobj,thisEvent)
        plot(tim,val)
        datetick('x','MM:SS FFF')
        drawnow
        delete(t)
        disp(['timer stopped at '...
            datestr(thisEvent.Data.time,'dd-mmm-yyyy HH:MM:SS.FFF')]);
    end

    function rceroddata(tobj,tevent)
        %temdata=tobj.userdata;
        %tobj.userdata=[temdata;rand,tim];
        tobj.tasksexecute
        disp(tobj.tasksexecute)
        n=tobj.tasksexecute;
        tim(n)=datenum(tevent.Data.time);
        sec=tevent.Data.time(6);
        val(n)=floor(sec);
       
        tim_base=datestr(tevent.Data.time,'MM:SS FFF');
        evalin('base',['tim(',num2str(n),',:)=''',tim_base,''';']);
    end

end