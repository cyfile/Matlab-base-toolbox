% a=py.xxx.stock_zh_a_hist("000001", "daily", "20200101", "20500101","")

adjust_dict = struct('qfq',"1", 'hfq', "2", 'default', "0");
period_dict = struct('daily', "101", 'weekly', "102", 'monthly', "103");
url = "http://push2his.eastmoney.com/api/qt/stock/kline/get";

period = 'daily';
adjust = 'default';
myprefix = '1';
symbol= '000001';
start_date=string( dateshift(datetime-years(2),'start','year'), 'yyyyMMdd'); %"20200101";
end_date=string( datetime+1, 'yyyyMMdd'); %"20500101";

options = weboptions("ContentType", 'json');
a = webread(url,  "fields1", "f1,f2,f3,f4,f5,f6", ...
    "fields2", "f51,f52,f53,f54,f55,f56,f57,f58,f59,f60,f61,f116",...
    "ut", "7eea3edcaed734bea9cbfc24409ed989",...
    "klt", getfield(period_dict,period),...
    "fqt", getfield(adjust_dict,adjust),...
    "secid", [myprefix  '.' symbol],...
    "beg", start_date,...
    "end", end_date,...
    "_", "1623766962675",...
    options);

splitFun = @(x) textscan(x,'%{yyyy-MM-dd}D %f %f %f %f %f %f %f %f %f %f','Delimiter',',');
b=cellfun(splitFun, a.data.klines , 'UniformOutput',false);
vName = {'date', 'open', 'close', 'high', 'low', 'volume', 'amount', ...
    'difference_percent',  'change_percent', 'change',   'turnover_rate' };
c = cell2table(vertcat(b{:}),'VariableNames',vName);

x=[c.open,c.close,c.low,c.high];
wday = weekday(c.date);
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
