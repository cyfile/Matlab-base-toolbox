ind = 1;
tab = zeros(50,7);
for a11=0.80:0.01:0.99
    for a12=0.01:0.01:0.2
        for a21=-0.05:0.01:-0.01
            for a22=0.80:0.01:0.99
                B = a12/(1-a11);
                A = (1-a11) / ( (1-a11)*(1-a22) - a21*a12 ) ;
                
                if 1.17<B && B<1.26 && abs(A-10) < 0.001
                    r = roots([1 -a11-a22 a11*a22-a21*a12]);
                    D = -real(log(r(1)))/abs(log(r(1)));
                    tab(ind,:)=[a11 a12 a21 a22 B A D];
                    ind = ind+1;
                end
                
            end
        end
    end
end


return
%%
k=5;
a11 = tab(k,1);a12 = tab(k,2);
a21 = tab(k,3);a22 = tab(k,4);

a11=0.96;a12 = 0.05;
a21 = -0.04;a22 = 0.95;

%%
z =zpk('z',1);
G = zpk(0,a22,1,1);
H1 = zpk([],a11,a12,1);
H2 = H1/z;
H = stack(1,H1,H2);
controlSystemDesigner

%%
% realp('K',0)
blk = tunableSS('ssAPM',2,2,1,1);
blk.A.Minimum=[0.89 0.01; -0.05 0.89];
blk.A.Maximum=[0.99 0.1;0 0.99];
blk.B.Value = [0;1];
blk.B.Free = [false;false];
blk.C.Value = [0.1 0;0 0.1];
blk.C.Free = [false false;false false];
blk.D.Value = [0;0];
blk.D.Free = [false;false];
blk.StateName= {'bgm','act'};
ss(blk);
controlSystemTuner(1*blk)

%%
z =zpk('z',1);
sys=a11 / (z - a12) / (z-a21);
figure
rlocus(sys)
rlocus(-sys)
rlocus(sys*z)
rlocus(-sys*z)
