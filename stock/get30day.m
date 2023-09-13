function r = get30day(symbol,tim)
% a=py.xxx.stock_zh_a_hist("000001", "daily", "20200101", "20500101","")
adjust_dict = struct('qfq',"1", 'hfq', "2", 'default', "0");
period_dict = struct('daily', "101", 'weekly', "102", 'monthly', "103");
url = "http://push2his.eastmoney.com/api/qt/stock/kline/get";

period = 'daily';
adjust = 'default';

if ~exist('symbol','var')
    market_id = '1';
    symbol= '000001';
else
    symbol =char(symbol);
%         sh=['688' '600' '603' '601' '605' '689'];
%         sz = ['300' '301' '000' '002' '001' '003'];
%         bj = ['872' '836' '873' '837' '835' '830' '871' '838'
%             '832' '833' '839' '430' '834' '831' '870']
    if symbol(1)=='6'
        market_id = '1';
    else
        market_id = '0';
    end    
end

if ~exist('tim','var')
    tim = datetime;
end

start_date=string( dateshift(tim - days(30),'start','week'), 'yyyyMMdd'); %"20200101";
% start_date=string( dateshift(datetime-years(2),'start','year'), 'yyyyMMdd'); %"20200101";
end_date=string( tim+1, 'yyyyMMdd'); %"20500101";

options = weboptions("ContentType", 'json');
a = webread(url,  "fields1", "f1,f2,f3,f4,f5,f6", ...
    "fields2", "f51,f52,f53,f54,f55,f56,f57,f58,f59,f60,f61,f116",...
    "ut", "7eea3edcaed734bea9cbfc24409ed989",...
    "klt", period_dict.(period),...
    "fqt", adjust_dict.(adjust),...
    "secid", [market_id  '.' symbol],...
    "beg", start_date,...
    "end", end_date,...
    "_", "1623766962675",...
    options);
%     "klt", getfield(period_dict,period),...
%     "fqt", getfield(adjust_dict,adjust),...
splitFun = @(x) textscan(x,'%{yyyy-MM-dd}D %f %f %f %f %f %f %f %f %f %f','Delimiter',',');
b=cellfun(splitFun, a.data.klines , 'UniformOutput',false);


vName = {'date', 'open', 'close', 'high', 'low', 'volume', 'amount', ...
    'difference_percent',  'change_percent', 'change',   'turnover_rate' };
c = cell2table(vertcat(b{:}),'VariableNames',vName);

r.code = a.data.code;
r.name = a.data.name;
r.date = c.date;
r.kkk=[c.open,c.close,c.low,c.high];


% wday = weekday(c.date);
end