function makebankmatfile(filename)
%创建一个空的mat文件
%
if ~nargin
    filename='tactics01';
end
fil=[filename,'.mat'];
savebankfile
copyfile('tmp.mat',fil)

msgbox(['文件',fil,'创建成功！'],'创建mat文件','help')