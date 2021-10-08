% serial date number
datenum('00-Jan-0000')
datenum('01-Jan-0001')
datevec('01-Jan-0001')
datestr([1487,1,1,11,0,0])
datestr([1487,1,1,11,0,1])

clk=now;
datenum(addtodate(clk, 1, 'hour'))-clk
1/24
datenum([2000,1,1,0,0,0])-datenum([2000,1,1,0,1,0])
1/24/60
datenum([2000,1,1,0,0,0])-datenum([2000,1,1,0,0,1])
1/24/60/60