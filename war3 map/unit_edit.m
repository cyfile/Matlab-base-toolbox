m = memmapfile('war3mapUnits.doo',...
    'Format',{'uint32',4,'Header'},'Repeat',1);
A = m.Data.Header;
fprintf('file ID               : %s\n',char( typecast(A(1), 'uint8') ));
fprintf('file version          : %d\n',A(2) );
fprintf('subversion?           : %d\n',A(3) ) ;
fprintf('number of units(items): %d\n',A(4) );
%%
% be careful! Each unit/item is defined by a data block of variable length
m = memmapfile('war3mapUnits.doo','Offset',4*4,'Writable', true,...
    'Format',{'uint8',[111 44],'units'},'Repeat',1);
A = m.Data.units;
A(9:16,1:40)=position;
m.Data.units=A;
%%
hhou=A(1:68,1);
sloc=A(1:68,41);
A(1:68,1:20)=repmat(sloc,1,20);
A(1:68,41:44)=repmat(hhou,1,4);
A(5,1:20)=0:19;
A(38,1:20)=0:19;
char(A(1:4,20))'
char(A(1:4,44))'
%% =================================================
return
%% =================================================
fileID = fopen('war3mapUnits.doo','r+');%
%ftell(fileID)
fseek(fileID, 24+4, -1);
ftell(fileID)
    fwrite(fileID, xx, '1*float', 107, 'ieee-le');
    
fseek(fileID, 28+4, -1);
ftell(fileID)
    fwrite(fileID, yy, '1*float', 107, 'ieee-le');

fclose(fileID)



