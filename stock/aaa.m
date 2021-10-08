%dftool
isconn=0;
contconn=0;
tic;
while  ~isconn && contconn<10 && toc<200
    contconn=contconn+1;
    try
        Yahoo_conn = yahoo;
        isconn=isconnection(Yahoo_conn);
        disp(['第 ' num2str(contconn) ' 次连接成功！'])
    catch e
        disp(['第 ' num2str(contconn) ' 次尝试连接失败'])
    end
end
if isconn
    %fprintf(2,'Congratulation: 尝试结束，连接成功！\n')
    warning('尝试结束，连接成功！')
else
    error('尝试结束，并未建立连接！')
end
%%
s_str='600000.ss';
todate   = floor(now);
fromdate = todate-60;
data=fetch(Yahoo_conn,s_str,fromdate,todate);

% 在我国特有的假期中股市是休市的，google并不知道，在这些日子中仍然记录股票数据
% 但当日的成交量为零，下面的这个语句剔除这些日期中的股票价格
data(data(:,6)<1,:)=[];

%ClosePrices = fetch(Yahoo_conn,s_str,'Close',floor(now)-10,floor(now))
Dates       = data(:,1);
OpenPrices  = data(:,2);
HighPrices  = data(:,3);
LowPrices   = data(:,4);
ClosePrices = data(:,5); 
close(Yahoo_conn)
%%
candle(HighPrices, LowPrices, ClosePrices, OpenPrices,'r', Dates,'mm/dd')
%, Dateform='mm/dd'
child=findobj(gca);
set(child(2),'facecolor','g') %下跌设为绿心
hold on
%%
Len=size(Dates,1);
Time(1:3:3*Len)=Dates+2/3;
Time(2:3:3*Len)=Dates+1/3;
Time(3:3:3*Len)=Dates;

Price(1:3:3*Len)=ClosePrices;
Price(2:3:3*Len)=(HighPrices+LowPrices)/2;
Price(3:3:3*Len)=OpenPrices;

plot(Time,Price)
datetick('x','mm/dd')
%%
mag_Price = detrend(fliplr(Price),'constant');
subplot(211)
plot(mag_Price)
Nfft=2^nextpow2(3*Len);
Fp=fft(mag_Price,Nfft);
k=Nfft/2;
f=Nfft./[0.5,1:k];
subplot(212)
plot(f,abs(Fp(1:k+1)))

return
%%
s_cell = {'A','B'};
s_cell={s_str}
Universe = builduniverse(Yahoo_conn,s_cell,floor(now)-10,floor(now));
Universe = periodicreturns(Universe,'d')
%%
[prc,act,div] = trpdata(Yahoo_conn,s_str,floor(now)-10,floor(now),'d')
