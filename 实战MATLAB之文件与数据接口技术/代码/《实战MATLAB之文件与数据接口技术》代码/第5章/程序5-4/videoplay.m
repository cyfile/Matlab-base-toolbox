%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 5-4 videoplay.m
function videoplay(filename)
%function videoplay(filename)

% 构造VideoReader对象
vobj = VideoReader(filename);

% 获取视频信息
nFrames = vobj.NumberOfFrames;
nHeight = vobj.Height;
nWidth = vobj.Width;
 
% 创建mov结构体
mov(1:nFrames) = ...
    struct('cdata', zeros(nHeight, nWidth, 3, 'uint8'),...
           'colormap', []);
 
% 从视频文件中读取视频帧
for k = 1 : nFrames
    mov(k).cdata = read(vobj, k);
end
 
% 打开图形窗口，并根据视频文件高度和宽度设置图形窗口尺寸
hf = figure;
set(hf, 'position', [150 150 nWidth nHeight])
 
% 播放视频
movie(hf, mov, 1, vobj.FrameRate);
end
