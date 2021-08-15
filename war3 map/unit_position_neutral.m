r0 = 70*64;

rc=([8 9 9 6 9]-2)*128 ;
zc=[30   105   180   250   320] ;

z0 = 0:30:350;
%%
xx = [(rc(2)-2*128)*cosd(z0+zc(2));...
    (rc(3)-2*128)*cosd(z0+zc(3));...
    (rc(5)-2*128)*cosd(z0+zc(5))] + r0*cosd(z0);
yy = [(rc(2)-2*128)*sind(z0+zc(2));...
    (rc(3)-2*128)*sind(z0+zc(3));...
    (rc(5)-2*128)*sind(z0+zc(5))] + r0*sind(z0);
x=round(xx'/64) * 64;y=round(yy'/64)*64;
plot(x(:),y(:),'o')
%%
Ux = reshape( typecast( single( x(:) ), 'uint8') , 4 ,[]);
Uy = reshape( typecast( single( y(:) ), 'uint8') , 4 ,[]);
%%
m = memmapfile('war3mapUnits.doo','Offset',4*4,'Writable', true,...
    'Format',{'uint8',[111 76],'units'},'Repeat',1);
A = m.Data.units;
A(9:16,41:76)=[Ux;Uy];
m.Data.units=A;