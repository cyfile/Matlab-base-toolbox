% Julia set 尤利亚集
% 尤利亚集  http://en.wikipedia.org/wiki/Julia_set
% 
% 曼德布罗集 http://en.wikipedia.org/wiki/Mandelbrot_set

 







 



 



N = 200;
interval=linspace(-2,2,600);
[x,y] = meshgrid(interval);
z = x + 1i*y;

count = zeros( size(z) );
for n = 0:N
    z = z.*z-0.8+0.156i;
    %z = z.*z+(0.99+0.14i)*z;
    inside = abs( z )<=0.4;%or 0.1 0.5
    count = count + inside;
end

%count = log( count+1 );

% Show

imagesc(interval,interval ,count);
axis image
title('Julia set');
colormap([summer;[1,1,1]])
%%
% colormap(hot)
%
% colormap(gray )