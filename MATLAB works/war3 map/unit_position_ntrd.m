a =[        5292          21          -2
        4673           9         -84
        4263          31         129
        3783          18        -159];
b = [        2429         -28          -5
        1951          -6          99
        1512         -36        -163];
xyf =[b(:,1).*cosd(b(:,2)) ,b(:,1).*sind(b(:,2))  ,(b(:,2)+b(:,3))*pi/180;
a(:,1).*cosd(a(:,2)) ,a(:,1).*sind(a(:,2))  ,(a(:,2)+a(:,3))*pi/180;
a(:,1).*cosd(a(:,2)+45) ,a(:,1).*sind(a(:,2)+45)  ,(a(:,2)+45+a(:,3))*pi/180]';
%%
plot(xyf(1,:),xyf(2,:),'o')
axis equal
%%
Ux = reshape( typecast( single( xyf(1,:) ), 'uint8') , 4 ,[]);
Uy = reshape( typecast( single( xyf(2,:) ), 'uint8') , 4 ,[]);
Uf = reshape( typecast( single( xyf(3,:) ), 'uint8') , 4 ,[]);
%%
m = memmapfile('war3mapUnits.doo','Offset',4*4,'Writable', true,...
    'Format',{'uint8',[111 75],'units'},'Repeat',1);
A = m.Data.units;
% A(1:4,65:75)= repmat(  uint8(('ntrd')'),1,16  );
A(9:16,65:75)=[Ux;Uy];
A(21:24,65:75)=Uf;
m.Data.units=A;