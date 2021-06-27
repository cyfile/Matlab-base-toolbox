function output_txt = textupdate(obj,event_obj)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

persistent s
if isempty(s)|| ~isvalid(s.h(1))
    s.autoflag = false;
    s.d =[0 ,0,0];
    ylim = getfield(gca,'YLim');
    s.h =[line([0,0],ylim,'Color','m'),...
        line([0,0],ylim,'Color','c'),...
        line([0,0],ylim,'Color','y')];
    s.p =[0,0,0];
end

pos = get(event_obj,'Position');
n = pos(1);
v = pos(2);

if s.autoflag
    output_txt = ['X::',num2str(n)];
    s.autoflag = false;
    return
end

switch obj
    case s.p(1)
        pt = 1;
    case s.p(2)
        pt = 2;
    case s.p(3)
        pt = 3;
    otherwise
        switch 0
            case s.p(1)
                pt = 1;
                s.p(1)= obj;
            case s.p(2)
                pt = 2;
                s.p(2)= obj;
            case s.p(3)
                pt = 3;
                s.p(3)= obj;
            otherwise
                delete(obj)
                return
        end
end

%if ~s.autoflag
st = max(1,n-200);
en = min(n+200,numel(obj.DataSource.YData));

[~,ind] = min(abs( ...
    obj.DataSource.YData(st:en).*...
    [0.05*(n-st)+0.95:-0.05:1,1,1:0.05:0.05*(en-n)+0.95] ));
nn = st+ind-1;
vv = obj.DataSource.YData(nn);

s.h(pt).XData=[nn,nn];
s.d(pt) = nn;
assignin('base', 'a', s.d);
display([num2str(v),'==>',num2str(vv),'       ',num2str(n),'==>',num2str(nn)])

if nn == n
    output_txt = ['X==',num2str(n)];
else
    s.autoflag = true;
    obj.Position=[nn,vv,0];
end
%end

