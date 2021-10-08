% KeyPressFcn
function eyechart
a=zeros(10);
a([3,4,7,8],3:end)=1;

drct=[29 30 28 31];
str='O  O  O  ';

fig=figure('Menubar','none',...
       'colormap',[0 0 0;1 1 1],...
       'color',[1,1,1],...
       'KeyPressFcn',@keyp);
ah=imagesc(a);
th=title(str,...
    'color','r',...
    'HorizontalAlignment','right',...
    'FontSize',25,...
    'fontw','bold')
axis equal
axis off
hold on

dind=randi(4);
set(ah,'Cdata',rot90(a,dind-1))
k=ylim;
guidata(fig,3)

    function keyp(obj,evt)
        num=double(evt.Character);
        if num==drct(dind)
            ty=guidata(fig);
            if ty>1
                guidata(fig,ty-1);
                set(th,'string',str(1:3*(ty-1)))
            else
                guidata(fig,3)
                tmp=k(2)/2;
                k=k+[-tmp,tmp];
                ylim(k)
                set(th,'string',str)
            end
            dind=randi(4);
            set(ah,'Cdata',rot90(a,dind-1))
        else
            beep
        end
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function gg
a=zeros(10);
a([3,4,7,8],3:end)=1;

drct=[29 30 28 31];
viang=[10 20 30 40 50];
eyep=1;

ddd=zeros(1,100);
ccc=zeros(1,100);
ppp=1;
rightcount=0;
wrongcount=0;

fig=figure('Menubar','none',...
    'colormap',[0 0 0;1 1 1],...
    'color',[1,1,1],...
    'KeyPressFcn',@keyp);

ddd(1)=randi(4);
ah=imagesc(rot90(a,ddd(1)-1));
axis off

    function keyp(~,evt)
        num=double(evt.Character);
        cdrt=find(drct==num);
        if cdrt
            ccc(ppp)=cdrt;
            if cdrt==ddd(ppp)
                if rightcount<2
                    rightcount=rightcount+1;
                elseif rightcount==2
                    rightcount=0;
                    wrongcount=0;
                    eyep=eyep+1;
                    set(gca,'cameraViewAngle',viang(eyep));
                end
               
            else
                wrongcount=wrongcount+1;
                if wrongcount==2
                    assignin('base', 'dd',ddd)
                    assignin('base', 'cc', ccc)
                    set(fig,'KeyPressFcn','');
                    disp(['您的视力为  ',num2str(eyep)])
                    beep
                end
               
            end
           
            ppp=ppp+1;
            ddd(ppp)=randi(4);
            set(ah,'Cdata',rot90(a,ddd(ppp)-1))
           
        else
            for m=1:4;beep,pause(0.03);end
        end
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

text(.5,.5,'XO\times\surd\heartsuit\spadesuit','fontsize',40,'color','r')