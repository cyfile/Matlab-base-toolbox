function [isvalid,allsymbols] = isvalidname(symbol)

if nargin == 0
    sts = ['600728';'736135';'001328';'300846']; % for test
    symbol = sts(1,:);
    disp("test " + symbol )
end


%         sh=['688' '600' '603' '601' '605' '689'];
%         sz = ['300' '301' '000' '002' '001' '003'];
%         bj = ['872' '836' '873' '837' '835' '830' '871' '838'
%             '832' '833' '839' '430' '834' '831' '870']
sh_1 = requests_get( "m:1 t:2,m:1 t:23" );
sz_0 = requests_get( "m:0 t:6,m:0 t:80" );
bj_0 = requests_get( "m:0 t:81 s:2048" );


allsymbols = [sh_1,sz_0,bj_0];

isvalid = any(allsymbols==symbol);

    function symarray = requests_get(fs)
        url = "http://80.push2.eastmoney.com/api/qt/clist/get";
        options = weboptions("ContentType", 'json');
        a = webread(url, ...
            "pn", "1",...
            "pz", "50000",...
            "po", "1",...
            "np", "1",...
            "ut", "bd1d9ddb04089700cf9c27f6f7426281",...
            "fltt", "2",...
            "invt", "2",...
            "fid", "f3",...
            "fs", fs,...
            "fields", "f12",...
            "_", "1623833739532",...
            options);
        symarray = string({a.data.diff.f12});
        % value = jsondecode(txt)
    end

end

