% round(a/64)*64
% 'ntav', 3904.0, 3392.0,
% 'ngad', 3840.0, 2176.0, 
% 'ngme', 4608.0, 896.0,
 
a=[ 3904.0, 3392.0
 3840.0, 2176.0
 4608.0, 896.0];
p1 = [60    52
    60    34
    72    14]'*64;
%        
z=45;
p23 =[cosd(z) -sind(z); 
    sind(z) cosd(z)]*p1;
%     cosd(2*z) -sind(2*z);
%     sind(2*z) cosd(2*z);
p = round([p1;p23]/64) * 64;
x = p(1:2:end,:); 
y = p(2:2:end,:);
xx = [x;-y;-x;y];
yy = [y;x;-y;-x];
%%
a=24;
plot(xx(1:a),yy(1:a),'o')
axis equal
%%
xx=[xx;zeros(4,3)];
yy=[yy;zeros(4,3)];
plot(xx(:),yy(:),'o')
%%
Ux = reshape( typecast( single( xx(:) ), 'uint8') , 4 ,[]);
Uy = reshape( typecast( single( yy(:) ), 'uint8') , 4 ,[]);
%%
m = memmapfile('war3mapUnits.doo','Offset',4*4,'Writable', true,...
    'Format',{'uint8',[111 76],'units'},'Repeat',1);
A = m.Data.units;
A(9:16,41:76)=[Ux;Uy];
m.Data.units=A;