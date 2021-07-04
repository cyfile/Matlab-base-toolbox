% handle handle.listener addlistener
function asdfasd

t=0:.1:10;
h=plot(t,0*t);
ylim([-1.2,1.2]);
hold on

hSlider = uicontrol('style','slider',...
    'pos',[20 20 120 20]);

%hListener = handle.listener(hSlider,'ActionEvent',@myCbFcn);
%hListener = addlistener(hSlider,'ActionEvent',@myCbFcn);
hListener = addlistener(hSlider,'ContinuousValueChange',@myCbFcn);
setappdata(hSlider,'sliderListener',hListener);

function myCbFcn(src,evnt)
    k=src.value;
    y=sin(k*t);
    set(h,'ydata',y)
end
end

 

% http://undocumentedmatlab.com/blog/continuous-slider-callback/