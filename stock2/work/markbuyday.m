function markbuyday(scod)

if ~exist('stockbuyday.mat','file')
    makebankmatfile
end


adddata={datestr(date,'yymmdd')};
matObj = matfile('stockbuyday.mat','Writable',true);

for m=1:10
    info = whos(matObj,['s',scod{m}]);
    if size(info,1)
        tem=num2str(info.size(2)+1);
        eval(['matObj.',['s',scod{m}],'(1,',tem,')=adddata;'])
    else
        eval(['matObj.',['s',scod{m}],'(1,1)=adddata;'])
    end
end

