% Open the text file.
fileID = fopen('C:\Users\Administrator\Desktop\Test.txt','r');
dataArray = textscan(fileID, '%f%f','HeaderLines', 2,...
    'Delimiter', ' ', 'MultipleDelimsAsOne', true, ...
    'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);
% Allocate imported array to column variable names
act = dataArray{ 1 };
bgm = dataArray{ 2 };
% Clear temporary variables
clearvars fileID dataArray ;
%%
load data;
N = numel(apmdata)+1;
apmdata{N}.act=act;apmdata{N}.bgm=bgm;
save("data","apmdata")
%%
% apmBGM = 0.95 * apmBGM/z + 0.06 * (apmRecorder/z + X); 
% apmRecorder =  - 0.02 * apmBGM/z + 0.92 * (apmRecorder/z + X);

% bgm = apmBGM;
% apm = apmRecorder + X*z

% bgm =  a11 * bgm/z + a12 * apm/z; 
% apm =  a21 * bgm/z + a22 * apm/z + X; % X 后面的*z 可有可无
a11=0.88;a12 = 0.15;
a21 = -0.04;a22 = 0.95;

A = [a11 a12;a21 a22];%[b;a]
B = [0;1];
%C = eye(2); 
C = [0 1];
D = 0;

sys = ss(A,B,C,D,-1);
% damp(sys)
sys_tf = tf(sys);
x = filter(sys_tf.Denominator{1},sys_tf.Numerator{1}(2:3),act);

z =zpk('z',1);
x2=lsim(1/sys/z,act);
all(abs(x-x2)<0.1)

y=lsim(sys,x,[]);
y2 = filter(ones(1,10),1,x);
y3 = conv(x,ones(1,10),'same');
%%
hold on;
plot(act)
plot(bgm)
plot(x)
plot(y)
plot(y2)
legend("act","bgm","x","y_{act}","y_{obj}")
%%
B = filter(0.09,[1,-0.9],act ,0 );
h=plot(B);
h.YDataSource = 'B';

B(1)=0 ;
for k =2:length(B)
%     if B(k-1) < 140
%         B(k)=0.92*140 +0.09*act(k-1)  ;
%     else
%         B(k)=0.92*B(k-1) +0.09*act(k-1)  ;
%     end
 B(k)=0.92*B(k-1) +13/( B(k-1)+0.2)*act(k-1)  ;
end
refreshdata



