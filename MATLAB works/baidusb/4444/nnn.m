% WindowButtonMotionFcn
function my_window_motion
%web([docroot '/techdoc/ref/figure_props.html#WindowButtonMotionFcn'])

%edit([docroot '/techdoc/ref/examples/window_motion_fcn'])
figure('WindowButtonDownFcn',@wbdcb)
ah = axes('DrawMode','fast');
axis ([1 10 1 10])
hold on
title('Click and drag')

allp=[];

    function wbdcb(src,evnt)
        if strcmp(get(src,'SelectionType'),'normal')
            set(src,'pointer','circle')
            cp = get(ah,'CurrentPoint');
           
            allp(end+1,:)=cp(1,1:2);
            xinit = cp(1,1);yinit = cp(1,2);
           
            hl = line('XData',xinit,'YData',yinit,...
                'Marker','*','color','b');
           
            set(src,'WindowButtonMotionFcn',@wbmcb)
            set(src,'WindowButtonUpFcn',@wbucb)
        end
       
        function wbmcb(src,evnt)
            cp = get(ah,'CurrentPoint');
            xdat = [xinit,cp(1,1)];
            ydat = [yinit,cp(1,2)];
            set(hl,'XData',xdat,'YData',ydat);drawnow
        end
       
        function wbucb(src,evnt)
            if strcmp(get(src,'SelectionType'),'alt')
               
                cp = get(ah,'CurrentPoint');
                allp(end+1,:)=cp(1,1:2);
               
                set(src,'Pointer','arrow')
                set(src,'WindowButtonMotionFcn','')
                set(src,'WindowButtonUpFcn','')
               
                line(allp([1,end],1),allp([1,end],2));
                fill(allp(:,1),allp(:,2),'g','facealpha',0.5,'EdgeColor','none')
            else
                return
            end
        end
    end
end