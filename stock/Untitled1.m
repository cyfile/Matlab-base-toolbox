% sts = {'600728','736135','001328' ,'300846'}
% a=cellfun(@(x) get30day(x),sts, 'UniformOutput',false);
% cellfun( @(x) class(x),aa, 'UniformOutput',false);
% b=cell2mat(a);


% "588050", 
stk_pool = ["601919", "601991", "688090", "000099", "000544", "002184"...
    "002380", "002542", "003037", "300036", "300242", "300284", "300346"...
    "300424", "300440", "300456", "300519", "300527", "300674", "300774"...
    "300989", "301136", "301226", "301330"];
% dbstop if error
dt = datetime('2023-07-21 10:15:14','InputFormat','yyyy-MM-dd HH:mm:ss');
% stks_info=arrayfun(@(x) get30day(x,dt),stk_pool);
stks_info=arrayfun(@(x) get30day(x),stk_pool);
% dbclear if error
%%
a=arrayfun(@(x) x, 1:length(stk_pool),'uni',false);
[stks_info.index]=deal(a{:});
b=arrayfun(@(x) length(x.date), stks_info,'uni',false);
[stks_info.N]=deal(b{:});

g=arrayfun(@(x) x.kkk(end,2),stks_info,'uni',false);
[stks_info.last]=deal(g{:});

% stks_info = rmfield(stks_info,'index2')
for k = 1:length(stk_pool)
    m = stks_info(k).kkk;
    len = stks_info(k).N;
    mask = hamming(len-1)'/sum(hamming(len-1));
    
    temp = [-mask,1]*log(m);
    stks_info(k).marker = [temp(1)/2+temp(2)/2 temp(3) temp(4)] ;
    
    temp = [mask,0]*log(m)+0.11;
    temp = exp(temp);
    stks_info(k).h = [temp(1)/4 + temp(2)/4 + temp(4)/2 , temp(4) ] ;
    
    temp = [mask,0]*log(m)-0.11;
    temp = exp(temp);
    stks_info(k).l = [temp(1)/4 + temp(2)/4 + temp(3)/2 , temp(3) ] ;
end


%%
T=array2table( cell2mat({stks_info.marker}') ,...
     'VariableNames',{'marker','low','high'} );

T.name = {stks_info.name}';
T.code = {stks_info.code}';
T.last = {stks_info.last}';
T.L = {stks_info.l}';
T.H = {stks_info.h}';
T.index = {stks_info.index}';
T.N = {stks_info.N}';

B = sortrows(T,'marker');
B(1:4,{'code','L'})
B(end-3:end,{'code','L'})
sprintf('%.2f',pi)
return
%%
clear classes
tmp = 'myio';
modd = py.importlib.import_module(tmp);
py.importlib.reload(modd);
% pyversion
py.list({py.list([1,2]),py.list([3,4])})
py.myio.myfun(123,'2','1')
%%
ind = 21;
ccc = stks_info(ind).code;
web(['http://quote.eastmoney.com/concept/sz',ccc,'.html'], '-browser')
%%
% !"E:\Program Files\google\Chrome\Application\chrome.exe" www.baidu.com
temp = mat2cell(stks_info(ind).kkk,stks_info(ind).N,[1,1,1,1]);
% temp=arrayfun(@(x) stks_info(1).kkk(:,x), [1,2,3,4], 'UniformOutput', false);
[OpenPrices,ClosePrices,LowPrices,HighPrices]=temp{:};

candle(HighPrices,LowPrices,ClosePrices,OpenPrices,'b',stks_info(ind).date)
return
%%
a=get1min();

return
%%
[L,N]=size(x);
a = lpc(x,7);
x_est = zeros(L+1,2);
for k=1:N
    x_est(:,k) = filter([0 -a(k,2:end)],1,[x(:,k);rand]);
end

%%
figure
set(gca,'colororder',lines(4))
hold on
ind=L-100:L;
plot(x(ind,:))
plot(x_est([ind,L+1],:),':')
plot(101+1,x_est(end,:),'*g')
plot(50*wday(ind)+2900,'r')
%%
A0=[x(L,:),x_est(L+1,:)];
A=[x(10:L-1,:),x_est(11:L,:)];
AA=[x(10:L-1,:),x_est(11:L,:),x(11:L,1)];
b=x(11:L,3:4);
[[A\b;0,0],AA\b]
C=A\b;
b_est=A*C;
%%
set(gca,'colororder',[lines(2);lines(2)])
hold on
hLine=plot([b,b_est]);
hLine(3).LineStyle='--';
hLine(4).LineStyle='--';
