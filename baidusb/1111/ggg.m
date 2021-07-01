% matlab��������
%musicbox
Fs=44100;%�趨����Ƶ��

%% �����׶�Ӧ��Ƶ��
 note=[-4,-2, 0, 1, 3, 5, 6, 8,10,12,13,15]; %diyin5daogaoyin2
%note=[G1,A1,B1, C, D, E, F, G, A, B, c, d]; %diyin5daogaoyin2

k=2^(1/12);%һ��������Ƶ������ϵ��
mnote=55*k.^(38+note);%������Ƶ��
%55 �� 38 ����Ϊ�˵��� C ��Ƶ�ʺ������ӽ������Ƴ�������������
%��Ҫ����֤����׼ȷ��Ƶ��ֻ��Ҫ���㹫��k��
%��Ƶ�ʺ�Ƶ�ʳ����ȣ��������ֱ�ӵ��ɽ�Ƶ�ʡ�

mn=[mnote*2*pi/Fs,0];%��������ÿһ���������Ӧ����λ���
                        %���һλ����ֹ������λ���

%% ͨ��������ÿ�����׵Ĳ���������Ӧ����λ���
numednote=[... %����
    -1,-1,3,3,       3,3 ,2,2,             3,3,3,3,              10,10,10,10,...
    2,2,2,2,         -2,-2,-1,0,           -1,-1,-1,-1,          10,10,10,10,...
    -1,-1,2,2,       2,2,1,1,              2,2,2,2,              10,10,10,10,...
    5,5,3,3,         2,2,5,5,              3,3,3,3,              10,10,10,10,...
    3,3,6,6,         6,6,5,5,              6,6,6,6,               6,6,5,5,...
    6,6,7,7,         2,2,5,5,              3,3,3,3,               -1,-1,1,1,...      //diyihang 96ge
    2,2,2,2,         2,2,2,3,              2,2,2,3,               1,1,0,0,...
    -1,-1,-1,-1,     10,10,10,10,       -1,-1,-1,-1,            10,10,10,10,... ///
    -1 ,-1,3,3,      3,3 ,2,2,            3,3,3,3,              10,10,10,10,...
    2,2,2,2,         -2,-2,0,0,           -1,-1,-1,-1,          10,10,10,10,...
    -1,-1,2,2,        2,2,1,1,              2,2,2,2,              10,10,10,10,...
    5,5,3,3,          2,2,5,5,              3,3,3,3,              10,10,10,10,...   //dierhang 192ge
    3,3,6,6,          6,6,5,5,              6,6,6,6,              6,6,5,5,...
    6,6,8,8,          2,2,5,5,              3,3,3,3,              -1,-1,1,1,...
    2,2,2,2,          2,2,3,3,              5,5,3,3,              9,9,8,8,...
    6,6,6,6,          10,10,10,10,          6,6,6,6,              10,10,10,10,...
    6,6,3,5,          6,6,6,6,              3,5,6,8,              6,6,6,6,...
    3,3,6,6,          6,8,6,6,              5,5,2,5,              3,3,3,3,...           //disanhang+1 288ge
    2,2,-1,1,         2,2,2,2,              1,2,3,5,               2,2,2,2,...
    -1,-1,2,2,        2,2,2,3,              1,-1,-2,1,            -1,-1,-1,-1];     %//288+32=320ge

mic=mn(numednote+3);%+3�����׵���������
%mic=[mn,mn];

%%
F_c=[4/3,2,3];%Ƶ�ʱ���ϵ���������Ը���18���ٸ߾�Ƿ��������
A_c=[0.04,0.08,0.85];%���ȱ���ϵ������Ͳ�Ӧ����1

L=Fs/10;%һ������ռ�еĲ���������ȷ������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ����һ

N=length(mic);
C=length(F_c);
S=[zeros(C,1),zeros(C,1)];

Y1=zeros(1,L*N);
for k=1:N
    if mic(k)~=0
        omega=mic(k)*kron(F_c',ones(1,L));
        delta=cumsum([S(:,1),omega],2);
        S(:,2)=mic(k);
    else
        omega=S(1,2)*kron(F_c',ones(1,L));
        delta=cumsum([S(:,1),omega],2);
        delta(delta>2*pi)=0;
        S(:,2)=0;
    end
    Y1(k*L-L+1:k*L)=A_c*sin(delta(:,2:end));
    S(:,1)=mod(delta(:,end),2*pi);
end

%%
W=0.9+0.1*sin((1:L*N)*2*pi*10/L);
Y1=Y1.*W;%�˸��������޲���
player1=audioplayer(Y1,Fs);
playblocking(player1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ������ %���ַŷ���ע�ͺ���Ҫ
% % %��������ܺã��ܼ򵥣�������̫����
% % delta=F_c'*mic;%��λϵ����Ȩ
% %                     %��λ���ϵ����
% % phase=cumsum(kron(delta,ones(1,L)),2);%�������������λ
% %                                        %Fs/n��������
% % Y2=A_c*sin(phase);%����ϵ����Ȩ
% %
% % player2=audioplayer(Y2,Fs);
% % playblocking(player2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% �Ӹ�˥��������������Ч��
D_c=1/2;%˥��ϵ��
Decay=logspace(0,log10(D_c),L+1);

PreviousNote=100;
N=length(mic);
BoxFrame=zeros(1,N);
for k=1:N;
    if mic(k)==PreviousNote || mic(k)==10;
        BoxFrame(k)=BoxFrame(k-1)*D_c;
    else
        BoxFrame(k)=1;
        PreviousNote=mic(k);
    end
end
Y3=Y1.*kron(BoxFrame,Decay(1:end-1));
player3=audioplayer(Y3,Fs);
playblocking(player3);