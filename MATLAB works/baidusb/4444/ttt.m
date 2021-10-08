% 各种凌乱，各种慢的魔方
function cube27
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(gcf,'Renderer','opengl')

poz=[0 0.7 0;0.5 0.5 0]';
az=[-37.5-90 -37.5+90 -37.5];
el=[30 30 -30];
ax=zeros(3,1);
for k=1:3
    ax(k)=axes('XLim',[-2 2],'YLim',[-2 2],...
        'ZLim',[-2 2],'position',[poz(k,:),0.3 0.5]);
    view(az(k),el(k))
    axis equal
    axis off
    %set(ax(k),'cameraviewanglemode','manual')
end

ax0 = axes('XLim',[-2 2],'YLim',[-2 2],...
    'ZLim',[-2 2]);
view(3); grid on; axis equal
set(ax0,'cameraviewanglemode','manual')
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[x,y]=meshgrid(-0.5:.5);
z=0.5*ones(2);
h(1) = surface(x,y,z,'FaceColor',hsv2rgb([1 0.4 1.0]));
h(2) = surface(x,y,-z,'FaceColor',hsv2rgb([5/6 0.4 1.0]));
h(3) = surface(z,x,y,'FaceColor',hsv2rgb([4/6 0.4 1.0]));
h(4) = surface(-z,x,y,'FaceColor',hsv2rgb([3/6 0.4 1.0]));
h(5) = surface(y,z,x,'FaceColor',hsv2rgb([2/6 0.4 1.0]));
h(6) = surface(y,-z,x,'FaceColor',hsv2rgb([1/6 0.4 1.0]));
%%%%
M=repmat(eye(4),[1,1,27]);
[ops{1:3}] = ndgrid(-1:1);
ops = reshape(cat(4,ops{:}),[],3)';
M(1:3,4,:)=ops;
%%%%
hall=hggroup('parent',ax0);
hcube(1)=hgtransform('Parent',hall,'matrix',M(:,:,1));
set(h,'Parent',hcube(1))
for k=2:27
    hcube(k) = copyobj(hcube(1),hall);
    set(hcube(k),'Matrix',M(:,:,k))
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%cube=reshape(1:27,3,3,3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
Str=['xxyyzz';'131313']';
Poz=[0.65 0.65 0.75 0.75 0.85 0.85;0.02 0.1 0.02 0.1 0.02 0.1]';
for k=1:6
    uicontrol('String',Str(k,:),...
        'Units','normalized', ...
        'Position', [Poz(k,:) 0.09 0.06],...
        'Interruptible','off',...
        'Callback', @butnrot,...
        'buttondownfcn',@butnrot2)
end
uicontrol('String','reset',...
    'Units','normalized', ...
    'Position', [0.85 0.18 0.09 0.06],...
    'Interruptible','off',...
    'Callback', @reset)

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
persistent cube

reset;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function butnrot(hObj,event)
        str=get(hObj,'string');
        cuberot(str(1),str2double(str(2)),-1)
    end
    function butnrot2(hObj,enent)
        if isequal(get(gcf,'selectiontype'),'alt')
            str=get(hObj,'string');
            cuberot(str(1),str2double(str(2)),1)
        end
    end
    function reset(hObj,event)
        for k=1:27
            set(hcube(k),'Matrix',M(:,:,k))
        end
        cube=reshape(1:27,3,3,3);
        cla(ax(1));
        cla(ax(2));
        cla(ax(3));
        copyobj(hall,ax);
    end
    function cuberot(axc,n,cflag)
        xi=1:3;
        yi=1:3;
        zi=1:3;
        eval([axc,'i=n;'])
        cube9=cube(xi,yi,zi);
        %cube9=cube9(:);
        Mt = makehgtform([axc,'rotate'],cflag*pi/24);
        for k=1:12
            Mp=get(hcube(cube9),'Matrix');
            Mn=cellfun(@(Mcell) Mt*Mcell,Mp,'uni',0);
            set(hcube(cube9),{'Matrix'},Mn)
           
            cla(ax(1));
            cla(ax(2));
            cla(ax(3));
            copyobj(hall,ax);
            pause(0.01)
        end
        switch axc
            case 'x'
                c9=shiftdim(cube9);
                c9=c9([3,2,1],:)';
            case 'y'
                c9=squeeze(cube9);
                c9=c9(:,[3,2,1])';
            case 'z'
                c9=cube9([3,2,1],:)';
        end
        if cflag==1
            c9=c9([3,2,1],[3,2,1]);
        end
        cube(xi,yi,zi)=c9;
    end
end