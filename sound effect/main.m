url = clipboard('paste');
temp = regexp(url,'playlist.m3u8','split');
pref = temp{1};

websave('playlist.m3u8',url);
fileID = fopen('playlist.m3u8','r');
dataArray = textscan(fileID, '%s%*s',10,'Whitespace',':', 'TextType', 'string');
for k=1:10
    if dataArray{1}(k) == "#EXTINF"
        break
    end
end
suf = dataArray{1}(k+1);

frewind(fileID);
dataArray = textscan(fileID, '%*s%f%*s','Delimiter',{',',':'},...
    'Whitespace','\n\r', 'EndOfLine', '#' ,'HeaderLines', k);
fclose(fileID);
%ftell(fileID)
tcum= cumsum( dataArray{1} );

clear url dataArray fileID k

%%
temp = 10311;
vind = find(tcum<60*floor(temp/100)+mod(temp,100),1,'last');
% if isempty(ind) ind = 0
% vind = vind +1;
%%
filename = [num2str(vind,'%03u') ,'.ts'];
newsuf = replace(suf,'000.ts',filename);
websave(filename, pref + newsuf);

[ans,~]=system( ['ffmpeg -i ',filename,' -vn -acodec copy a.mp4 -y'])
%!ffmpeg -i 999.ts -vn -acodec copy a.mp4 -y
[y,Fs] = audioread('a.mp4');
%%
%[ye,Fs] = audioread('HeroArchMageYes1.wav');
%[ye,Fs] = audioread('JainaPissed4.wav');
%plot(sort(abs(ye)));
%sound(ye,Fs);
%%
axes('Position',[0.04 0.15 0.95 0.8]);
plot(y(:,1))
%plot([y(:,1),y(:,2)+0.6])

a = [1,length(y)/2,length(y)];
uicontrol('Style', 'pushbutton', 'String', 'playAB',...
        'Position', [100 20 50 20],...
        'Callback', 'evalin(''base'', ''soundsc(y(min(a):median(a),1),Fs)'')');     
uicontrol('Style', 'pushbutton', 'String', 'playAC',...
        'Position', [250 20 50 20],...
        'Callback', 'evalin(''base'', ''soundsc(y(min(a):max(a),1),Fs)'')'); 
    uicontrol('Style', 'pushbutton', 'String', 'playBC',...
        'Position', [400 20 50 20],...
        'Callback', 'evalin(''base'', ''soundsc(y(median(a):max(a),1),Fs)'')');
hdt = datacursormode;
hdt.UpdateFcn = @(obj,event_obj) textupdate(obj,event_obj);

%%
yn=y(min(a):2:max(a),1);% downsample(y,2)
A =0.30/quantile(abs(yn),0.90);
yout = A*yn; 
audiowrite('out.wav',yout,Fs/2)
sound(yout,Fs/2);
%soundsc();


