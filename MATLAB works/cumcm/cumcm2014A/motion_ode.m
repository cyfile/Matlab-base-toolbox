function dydt = motion_ode(t,y,tfn,f,tgn,g)
%% 微分方程运动模型
fn = interp1(tfn,f,t); % Interpolate the data set (ft,f) at time t
ft = interp1(tgn,g,t); % Interpolate the data set (gt,g) at time t
%
% y1=R;
% y2=Theta;
% y3=R^\prime;
% y4=Theta^\prime;
% y5=m;
%
M=7.3477e22;
G=6.674e-11;
v_e=2940;
dydt =[ y(3);
    y(4);
    fn/y(5)-G*M/y(1)/y(1)+y(1)*y(4)*y(4);
    -ft/y(5)/y(1)-2*y(3)*y(4)/y(1);
    -sqrt(ft^2+fn^2)/v_e];