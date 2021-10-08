function marknewbuy(resul,filename)
%记录挑选的目标股票到文件
%
filename='tactics01';
%matObj = matfile(filename);


a=zeros(1,6);
 a(1)=5;
 a(2)=floor(addtodate(now, 1, 'day'));%datenum
 a(4)=floor(addtodate(now, 2, 'day'));%datenum

        
load(filename)

for k=1:length(resul)
    if exist(['sh',resul{k}],'var')
        if eval(['isequal(sh',resul{k},'(end,:),a)']);
            continue
        else
        eval(['sh',resul{k},'(end+1,:)=a;']);
        save(filename,['sh',resul{k}],'-append');
        end
    else
        eval(['sh',resul{k},'=a;']);
        save(filename,['sh',resul{k}],'-append');
    end
end