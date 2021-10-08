function profileofbigdeal(matf)
%
if ~nargin
    filename=['bigdeal\',datestr(date,'yymmdd')];
    matf=[filename,'.mat'];
end



% tic
% load(matf)
% totdeal=size(s,1)
% toc

% tic
matObj = matfile(matf);
totdeal=size(matObj,'s',1);
% toc 


pag=ceil(totdeal/50);
lapag=rem(totdeal,50);
disp('截至目前')
disp(['今日共有超过千万大单共',num2str(totdeal),'单'])
disp(['共',num2str(pag),'页,','最后一页共有',num2str(lapag),'单'])
disp('最后（或者是第一）单为:')
disp(matObj.s(totdeal,:))
%disp([s{end,:}])


