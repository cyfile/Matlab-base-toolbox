% stepAnnotation

% for k=[100 20]
    k=50;
    sys=tf([11 k],[1 12 k]);
    sysn=tf(-1,[1 12 k]);
    t=0:.01:3;
    step(sys,'b',sysn,'r',t);
    S=stepinfo(sys);
 
    str={['K=',num2str(k)];['\sigma%\approx',num2str(S.Overshoot),'%'];...
        ['t_s\approx',num2str(S.SettlingTime),'s']};
   
    text(2,0.7,str)
    %%
%     hold on;
% end
% %  [u,t2] = gensig('sin',1);
% % 
% %  lsim(sys,u,t2)