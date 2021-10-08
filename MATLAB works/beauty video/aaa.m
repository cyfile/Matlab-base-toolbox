info = mmfileinfo('square.mp4')
v = VideoReader('square.mp4')
v.CurrentTime
last = v.Duration*v.FrameRate-1;
frame = read(v,last);
imshow(frame)