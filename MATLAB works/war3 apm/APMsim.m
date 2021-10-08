load data;
N = numel(apmdata);
% N =1;
act = apmdata{N}.act;
bgm = apmdata{N}.bgm;
clearvars apmdata;
%%
C=0.9;%
x = filter([1 -C], C ,act);
act4 = filter(ones(1,10),1,x);
act0=zeros(size(x));
bgm0=zeros(size(x));
act0(1)=x(1);
bgm0(1)=0;%zi
%%
%easy
a11=0.85;a12 = 0.18;
a21 = -0.05;a22 = 0.96;

%hard
a11=0.84;a12 = 0.20;
a21 = -0.04;a22 = 0.95;
a11=0.88;a12 = 0.15;
a21 = -0.04;a22 = 0.95;
%%
A = [a11 a12;a21 a22];%[b;a]
B = [0;1];
C = eye(2); %C = [0 1];
D = 0;
sys = ss(A,B,C,D,-1);
y = lsim(sys,x,[]);
figure
plot(act4)
hold on
plot(y)
hold off

%%
for k =2:length(x)
    %     apmBGM = a11 * apmBGM/z + a12 * apmRecorder/z;
    %     apmRecorder = a21 * apmBGM/z + a22 * apmRecorder/z;
    bgm0(k) = a11*bgm0(k-1) + a12*act0(k-1) ;
    act0(k) = a21*bgm0(k-1) + a22*act0(k-1)+x(k) ;
end
plot(act4)
hold on
plot(act0)
plot(bgm0)
hold off