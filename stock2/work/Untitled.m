resu=choosestock
marknewbuy(resu)

%filename=datestr(addtodate(now, -1, 'day'),'yymmdd');
fil=['bigdeal\',filename,'.mat'];
[scod,tmp]=goodstockofbigdeal(fil);


%%%%%%%%%%%%%%%%%%%%
filename='tactics01';
load(filename);
nstks=who('sh*');

for m=1:length(nstks)
eval(['a=',nstks{m},';'])
%datestr(now,'yymmdd')
ind=find(a(:,1)==5);
for k=ind'
a(k,3)=daydata(nstks{m},a(k,2));
a(k,1)=4;
end
eval([nstks{m},'=a;'])
save(filename,nstks{m},'-append');
end

%%%%%%%%%%%%%%%%%55


