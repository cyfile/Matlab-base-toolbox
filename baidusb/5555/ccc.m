% 使用 matlab 制作月历桌面
function markcal
cal=calendar(addtodate(now,1,'m'));
cal=calendar;
[x,y]=meshgrid(0.2:0.05:0.50,0.55:-0.05:0.3);
%%
mskz=false(size(cal));
msk=cal>0;

msks=mskz';
msks(find(msk',9,'first'))=1;
msks=msks';

mskd=xor(msk,msks);

mskh=mskz;
mskh(:,1)=1;
mskh(:,end)=1;
%%
rd1=mskh&msks;
bk1=~mskh&msks;
rd2=mskh&mskd;
bk2=~mskh&mskd;

%%
%%%%%%%%%%%%%%%%%%
clf
arrayfun(@(x,y,a) ...
    text(x,y,[' ',num2str(a)],...
    'fontsize',20,'fontname','tahoma'),...
    x(bk1),y(bk1),cal(bk1));
arrayfun(@(x,y,a) ...
    text(x,y,num2str(a),...
    'fontsize',20,'fontname','tahoma'),...
    x(bk2),y(bk2),cal(bk2));
%datestr([2:7,1],'ddd')
%[~,wd]=weekday(1:7,'short');
arrayfun(@(x,y,a) text(x,y,datestr(a,'ddd'),...
    'fontsize',12,'fontname','tahoma','fontweight','bold'),...
    x(1,2:end-1),y(1,2:end-1)+0.05,3:7)
text(x(1,6),y(1)+0.1,datestr(date,'yyyy/mm'),...
    'fontsize',14,'fontname','georgia','fontweight','bold')

[lyrbk,modbk]=extract;
%%
%%%%%%%%%%%%%%%%%%%%
clf
arrayfun(@(x,y,a) ...
    text(x,y,[' ',num2str(a)],...
    'fontsize',20,'fontname','tahoma'),...
    x(rd1),y(rd1),cal(rd1));
arrayfun(@(x,y,a) ...
    text(x,y,num2str(a),...
    'fontsize',20,'fontname','tahoma'),...
    x(rd2),y(rd2),cal(rd2));
%datestr([2:7,1],'ddd')
%[~,wd]=weekday(1:7,'short');
arrayfun(@(x,y,a) text(x,y,datestr(a,'ddd'),...
    'fontsize',12,'fontname','tahoma','fontweight','bold'),...
    x(1,[1,end]),y(1,[1,end])+0.05,[2,1])

[lyrrd,modrd]=extract;
%%
%%%%%%%%%%%%%%%%%%%%%%
clf
text(x(1,1),y(1)+0.12,datestr(now,'mmmm'),...
    'fontsize',24,'fontname','georgia','fontweight','bold')

[lyrtit,modtit]=extract;
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
[fi,pa]=uigetfile('*.jpg','选择要添加月历的jpg格式图像文件');
A = imread([pa,fi]);
rgb=zeros(1,3);
for k=1:3
    counts = imhist(A(:,:,k));
    [~,tmp]=max(counts(20:230));
    rgb(k)=tmp+20;
end
tmp=rgb2hsv(rgb);
tmp(1)=rem(tmp(1)+1/3,1);
ncol1=hsv2rgb(tmp);
tmp(1)=rem(tmp(1)+1/3,1);
ncol2=hsv2rgb(tmp);
%%
a=size(lyrbk,1);
b=size(lyrbk,2);
c=size(A,1);
d=size(A,2);
if 99+a>c||599+b>d
    error('图片太小了')
end
patc=false(c,d);

prcpic(lyrbk,modbk,ncol1,rgb)
%imshow(A)
prcpic(lyrrd,modrd,ncol2,rgb)
%imshow(A)
prcpic(lyrtit,modtit,ncol1,rgb)
filename=['mywallpaper',num2str(month(now)),'.jpg'];
imwrite(A,filename,'jpg');
eval(['!',filename])
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%
%%
    function prcpic(lyr,mod,ncol,rgb)
        % image(A)
        % ginput(1)
        patc(100:99+a,600:599+b)=lyr;
        for k=1:3
            Ao=A(:,:,k);
           
            cmap=floor(linspace(ncol(k),rgb(k),256));
            tmpa=cmap(mod+1);
           
            Ao(patc)=tmpa(lyr);
           
            A(:,:,k)=Ao;
        end
    end

%%
%%%%%%%%%%%
    function [lyrind,lyrmod]=extract
        set(gcf,'position',[1 31 1024 650])
        f = getframe;              %Capture screen shot
        layer=f.cdata(150:400,150:450,:);
        %251*301
        lyrmod=layer(:,:,1);
        lyrind=lyrmod~=255;
       
        % image(layer)
        % imshow(layer)
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end