%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 5-3 Movie2aviExample.m
nframe = 30;%设定帧数
x1 = linspace(0,2.5*pi,nframe);

%构造mov结构
mov(1:nframe) = struct('cdata', [], 'colormap', []);
 
coef = 10*cos(x1);
hf =figure;
[x,y,z] = peaks;
for k=1:length(coef )
    % 绘制图像数据，生成视频文件帧图像
    h = surf(x,y,coef (k)*z);
    shading interp;axis off;
    colormap(hsv);
    axis([-3 3 -3 3 -80 80])
    axis off
    caxis([-90 90])
    % 获取数据帧，并将数据帧图像添加到AVI文件中
    mov(k) = getframe(hf);%   
end
close(hf);%关闭MATLAB图形窗口句柄
movie2avi(mov,'peaks_mov.avi','compression','none');
