m = memmapfile('war3mapUnits.doo',...
    'Format',{'uint32',4,'Header'},'Repeat',1);
A = m.Data.Header;
fprintf('file ID               : %s\n',char( typecast(A(1), 'uint8') ));
fprintf('file version          : %d\n',A(2) );
fprintf('subversion?           : %d\n',A(3) ) ;
fprintf('number of units(items): %d\n',A(4) );
unitN = double(A(4));
%%
% be careful! Each unit/item is defined by a data block of variable length
unitN= 76;
m = memmapfile('war3mapUnits.doo','Offset',4*4,'Writable', true,...
    'Format',{'uint8',[111 unitN],'units'},'Repeat',1);
A = m.Data.units;
A(9:16,1:40)=position;
m.Data.units=A;
%%
name =string(char(A(1:4,:)'));
% ngad Goblin Laboratory
% ntav Tavern
% ngme Goblin Merchant
% sloc
ngad=A(1:4,41);
ntav=A(1:4,53);
ngme=A(1:4,65);
A(1:4,41:52)=repmat(ntav,1,12);
A(1:4,53:64)=repmat(ngme,1,12);
A(1:4,65:76)=repmat(ntav,1,12);

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



