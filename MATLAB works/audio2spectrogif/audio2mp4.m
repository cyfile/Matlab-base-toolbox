

if ~exist('data_sound','var')
    scriptDir = fileparts(mfilename('fullpath'));  
    % disp(['Retrieve the directory path of this executing script: ', scriptDir]);
    fileToRead = scriptDir+"\output.aac";

    newData = importdata(fileToRead);
    
    data_sound = newData.data(:,2);
    fs = newData.fs; % Hz
    time_length = (length(data_sound)-1)/fs;
end

%%

if exist('ax','var') && ishandle(ax)
    isa(ax,'matlab.graphics.axis.Axes');
    disp(ax);
    class(ax);
    axes(ax);

else
%     set(gcf, 'WindowState', 'fullscreen');
    ax = draw_pspectrum(data_sound,fs);
%     set(gcf, 'Position', [10, 10, 800, 600]);
end
%%
% close all

hold on

% set(gcf, 'WindowState', 'maximized');
ax.Units = 'pixels';

pos = floor(ax.Position);
pos = floor(ax.Position/2)*2;
marg = 30;
rect = [-marg, -marg, pos(3)+2*marg, pos(4)+2*marg]

lim = axis;
lim_x = xlim;
lim_y = ylim;
lim_w = 0.01*(lim(2)-lim(1));
lim_h = 0.2*(lim(4)-lim(3));

htf = hgtransform('parent',gca);
rectangle('Position',[lim_x(1)-lim_w,lim_y(1),2*lim_w,1.2*lim_h], 'parent',htf,...
    'FaceColor','none','EdgeColor','k','LineWidth',1)
%     'FaceColor','blue', ...

% line([lim_x(1),lim_x(1)],[lim_y(1),lim(3)+lim_h],'parent',htf, ...
%     'color','k','LineWidth',5);
line([lim_x(1),lim_x(1)],[lim_y(1),lim_y(2)],'parent',htf, ...
    'color','r','LineWidth',1);

% h = plot(0,0,'XDataSource','x','YDataSource','y','linesmoothing','on');
% hl = line([lim(1),lim(1);lim(1),lim(2)],[lim(3),lim(3);lim(4),lim_h],'parent',htf);
% set(hl(1),'color','r','LineWidth',1)
% set(hl(2),'color','b','LineWidth',3)


%%
filename = 'datacursor.gif';
N=100;
frame_tick = linspace(0,lim_x(2)-lim_x(1),N);
delay_time = time_length/N;
F=getframe(gca,rect);
% F.cdata(end,:,:)=[];
[im,map]=rgb2ind(frame2im(F),256);
imwrite(im,map,filename,'gif','LoopCount',Inf,'DelayTime',delay_time);
% !ffmpeg -i datacursor.gif -hide_banner
! ffmpeg -i datacursor.gif -hide_banner
% return
%%

for k = frame_tick(2:end)
    M= makehgtform('translate',[k 0 0]);
    set(htf,'Matrix',M)
%     pause(0.4)
    drawnow
    axis(lim)
    % axis equal
    F=getframe(gca,rect);
%     F.cdata(end,:,:)=[];
    [im,map]=rgb2ind(frame2im(F),256);
    imwrite(im,map,filename,'gif','WriteMode','append','DelayTime',delay_time);
end

%%
! ffmpeg  -hide_banner -i datacursor.gif -i output.aac -c:v libx264 -pix_fmt yuv420p out.mp4

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

function ax = draw_pspectrum(data,fs)
    data = lowpass(data,520,fs,'Steepness',0.9999,'StopbandAttenuation',60);
    % Parameters
    frequencyLimits = [0 500]; % Hz
    overlapPercent = 30;
    reassignFlag = true;
    timeValues = (0:length(data)-1).'/fs;
    
    % Compute spectral estimate
    % Run the function call below without output arguments to plot the results
    % [P,F,T] = 
    pspectrum(data,timeValues, ...
        'spectrogram', ...
        'FrequencyLimits',frequencyLimits, ...
        'OverlapPercent',overlapPercent, ...
        'Reassign',reassignFlag);
    caxis([-50,-20])
    colorbar('off')
    title('') 
    ax =  gca;
end





