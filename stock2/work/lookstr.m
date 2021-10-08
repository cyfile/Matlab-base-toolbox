function lookstr(filename,str)
%将读入的url文件转换成正确格式后存入文本，并打开
s = regexprep(str, '%', '%%');

fileID=[filename,'.txt'];
fid = fopen(fileID, 'w');
fprintf(fid, s);
%fwrite(fid, '文字')
fclose(fid);
edit(fileID)