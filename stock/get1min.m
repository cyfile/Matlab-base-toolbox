function r = get1min(symbol,market_id)

switch nargin
    case 2
        
    case 1
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
    otherwise
        symbol = '603777';
        market_id = '1';
end


url = "https://push2his.eastmoney.com/api/qt/stock/trends2/get";
options = weboptions("ContentType", 'json');
a = webread(url,  "fields1", "f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13",...
            "fields2", "f51,f52,f53,f54,f55,f56,f57,f58",...
            "ut", "7eea3edcaed734bea9cbfc24409ed989",...
            "ndays", "5",...
            "iscr", "0",...
            "secid", [market_id  '.' symbol],...
    "_", "1623766962675",...
    options);

% assignin('base', 'infun', a.data.trends);

splitFun = @(x) textscan(x,'%{yyyy-MM-dd HH:mm}D %f %f %f %f %f %f %f','Delimiter',',');
b=cellfun(splitFun, a.data.trends , 'UniformOutput',false);
vName = {'date', 'open', 'close', 'high', 'low', 'volume', 'amount', ...
    'last' };
c = cell2table(vertcat(b{:}),'VariableNames',vName);

r.code = a.data.code;
r.name = a.data.name;
r.date = c.date;
r.kkk=[c.open,c.close,c.low,c.high];

end

