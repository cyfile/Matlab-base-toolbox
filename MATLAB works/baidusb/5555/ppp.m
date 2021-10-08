% 由矩阵生成latex表格数据
function creatlatextable(filename,var,f)
%
if ~exist('f','var')
    if exist([filename,'.txt'],'file')
        disp('该文件已存在！')
        a=input('是否覆盖？\n','s');
        if a~='y'
            return
        end
    end
end
[r,c]=size(var);
fileID = fopen([filename,'.txt'],'w');
for k=1:r
    for kk=1:c-1
        fprintf(fileID,'%8.4f  & ',var(k,kk));
    end
    fprintf(fileID,'%8.4f  \\\\ \n',var(k,kk+1));
end
fclose(fileID);