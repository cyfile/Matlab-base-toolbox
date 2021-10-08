% interruptplot
a=zeros(1,256);
b=abs(fft(a));
h=plot(b,'ydatasource','b');
% % choice = questdlg('Please choose a dessert:', ...
% %     'Dessert Menu','hold','pause','stop','stop');
h1=msgbox('Press the button to stop','Stop box',...
   'warn' );
% % set(h1,'buttondownfcn','break')
% % waitforbuttonpress;

for b=1:256
    a(b)=1;
    b=abs(fft(a));
    refreshdata(h,'caller');
    pause(0.04)
    if ~ishandle(h1)
        break
    end
% %     switch choice
% %         case 'stop'
% %             break
% %     end
% %     
    
end