% waveletsound
Fs=11025;
pt=0.1;
t0=linspace(0,pt,pt*Fs);

%-------------------------mn and mic-------------------------------------
note=[-4,-2,0,1,3,5,6,8,10,12,13,15]; %diyin5daogaoyin2

k=2^(1/12);
a=55;
mnote=a*k.^(38+note);
mn=[mnote,0];



numednote=[-1,-1,3,3,       3,3 ,2,2,            3,3,3,3,              10,10,10,10,...
    2,2,2,2,         -2,-2,-1,0,           -1,-1,-1,-1,          10,10,10,10,...
    -1,-1,2,2,       2,2,1,1,              2,2,2,2,              10,10,10,10,...
    5,5,3,3,         2,2,5,5,              3,3,3,3,              10,10,10,10,...
    3,3,6,6,         6,6,5,5,              6,6,6,6,               6,6,5,5,...
    6,6,7,7,         2,2,5,5,              3,3,3,3,               -1,-1,1,1,...      //diyihang 96ge
    2,2,2,2,         2,2,2,3,              2,2,2,3,               1,1,0,0,...
    -1,-1,-1,-1,     10,10,10,10,     -1,-1,-1,-1,           10,10,10,10,... ///
    -1 ,-1,3,3,       3,3 ,2,2,            3,3,3,3,              10,10,10,10,...
    2,2,2,2,          -2,-2,0,0,           -1,-1,-1,-1,          10,10,10,10,...
    -1,-1,2,2,        2,2,1,1,              2,2,2,2,              10,10,10,10,...
    5,5,3,3,          2,2,5,5,              3,3,3,3,              10,10,10,10,...   //dierhang 192ge
    3,3,6,6,          6,6,5,5,              6,6,6,6,              6,6,5,5,...
    6,6,8,8,          2,2,5,5,              3,3,3,3,              -1,-1,1,1,...
    2,2,2,2,          2,2,3,3,              5,5,3,3,              9,9,8,8,...
    6,6,6,6,         10,10,10,10,      6,6,6,6,              10,10,10,10,...
    6,6,3,5,          6,6,6,6,              3,5,6,8,              6,6,6,6,...
    3,3,6,6,          6,8,6,6,              5,5,2,5,              3,3,3,3,...           //disanhang+1 288ge
    2,2,-1,1,         2,2,2,2,             1,2,3,5,               2,2,2,2,...
    -1,-1,2,2,        2,2,2,3,              1,-1,-2,1,            -1,-1,-1,-1];     %//288+32=320ge

mic= numednote+3;
clear numednote note mnote a k
%-------------------------------------------------------------------------------

%%%%%%%%%%%%%%
%1111111111111111111111111111
% gw=@(f) sin(2*pi*f*linspace(0,pt,pt*Fs));
% for k=mic
%     wavplay(gw(mn(k)),Fs)
% end
%%%%%%%%%%%%%%%%

%%%%%%%%%%%%
% 222222222222222222222
% gw=@(f) sin(2*pi*f*linspace(0,pt,pt*Fs));
% w=arrayfun(gw,mn(mic),'UniformOutput',false);
% w2=cell2mat(w);
% wavplay(w2,Fs);
%%%%%%%%%%%%%%%

%%%%%%%%%%%%
% 33333333333333333333333
gw=@(k,f) sin(2*pi*f*((k-1)*pt+t0(2)+t0));
w=arrayfun(gw,1:320,mn(mic),'UniformOutput',false);
w2=cell2mat(w);
wavplay(w2,Fs);
%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%
%444444444444444444
[PHI,PSI,XVAL] = wavefun('meyr',11);
fc=PSI(600:1300);

[~,k]=findpeaks(-abs(fc));
fc=fc(k(1):k(end));

fc=2*fc/(max(fc)-min(fc));
fc=1+fc-max(fc);

n=length(fc);
fc=fc(1:end-1);

% fc=cos(linspace(0,2*pi,n));
ff=@(t) fc(1+floor((n-1)*mod(t,2*pi)/2/pi));
gw=@(k,f) ff(2*pi*f*((k-1)*pt+t0(2)+t0));
w=arrayfun(gw,1:320,mn(mic)/2,'UniformOutput',false);
w2=cell2mat(w);
wavplay(w2,Fs);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%
%5555555555555555555555
[PHI,PSI,XVAL] = wavefun('db8',11);
fc=PHI(1:15000);

[~,k]=findpeaks(-abs(fc));
fc=fc(1:k(end));

fc=2*fc/(max(fc)-min(fc));
fc=1+fc-max(fc);

n=length(fc);
fc=fc(1:end-1);

% fc=cos(linspace(0,2*pi,n));
ff=@(t) fc(1+floor((n-1)*mod(t,2*pi)/2/pi));
gw=@(k,f) ff(2*pi*f*((k-1)*pt+t0(2)+t0));
w=arrayfun(gw,1:320,mn(mic)/2,'UniformOutput',false);
w2=cell2mat(w);
wavplay(w2,Fs);
%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%
%666666666666666666
[PSI,XVAL] = wavefun('mexh',11);
[~,k]=max(PSI);
fc=PSI(k-500:k+500);

fc=2*fc/(max(fc)-min(fc));
fc=1+fc-max(fc);

n=length(fc);
fc=fc(1:end-1);

% fc=cos(linspace(0,2*pi,n));
ff=@(t) fc(1+floor((n-1)*mod(t,2*pi)/2/pi));
gw=@(k,f) ff(2*pi*f*((k-1)*pt+t0(2)+t0));
w=arrayfun(gw,1:320,mn(mic)/2,'UniformOutput',false);
w2=cell2mat(w);
wavplay(w2,Fs);
%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%
%7777777777777777
[PHI,PSI,XVAL] = wavefun('sym2',11);
fc=PSI;

fc=2*fc/(max(fc)-min(fc));
fc=1+fc-max(fc);

n=length(fc);
fc=fc(1:end-1);

% fc=cos(linspace(0,2*pi,n));
ff=@(t) fc(1+floor((n-1)*mod(t,2*pi)/2/pi));
gw=@(k,f) ff(2*pi*f*((k-1)*pt+t0(2)+t0));
w=arrayfun(gw,1:320,mn(mic)/2,'UniformOutput',false);
w2=cell2mat(w);
wavplay(w2,Fs);
%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%
%888888888888888888888888
t=0:.01:11;
fc=4*sin(t)+3*sin(1.5*t)+2*sin(2*t)+sin(2.5*t);

[~,k]=findpeaks(-abs(fc));
fc=fc(1:k(end));

fc=[.5*fc(1:k(1)),fc(k(1)+1:end)];

fc=2*fc/(max(fc)-min(fc));
fc=1+fc-max(fc);

n=length(fc);
fc=fc(1:end-1);

% fc=cos(linspace(0,2*pi,n));
ff=@(t) fc(1+floor((n-1)*mod(t,2*pi)/2/pi));
gw=@(k,f) ff(2*pi*f*((k-1)*pt+t0(2)+t0));
w=arrayfun(gw,1:320,mn(mic),'UniformOutput',false);
w2=cell2mat(w);
wavplay(w2,Fs);