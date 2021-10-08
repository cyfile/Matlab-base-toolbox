%% create file "war3map.doo" form "wa3map - src.doo"
fileID = fopen('war3mapdoo','w');
N = 32*32;
%%
% copyfile('war3map.doo',  'war3map - src.doo')
m = memmapfile('war3map - src.doo',...
    'Format',{'uint32',4,'Header'},'Repeat',1);
A = m.Data.Header;
fprintf('file ID         : %s\n',char( typecast(A(1), 'uint8') ));
fprintf('file version    : %d\n',A(2) );
fprintf('subversion?     : %d\n',A(3) ) ;
fprintf('number of trees : %d\n',A(4) );

A(4) = N;
fwrite(fileID, A,'uint32')

%%
% Each tree is defined by a 50 bytes block(file version: 8, subversion: 11)
m = memmapfile('war3map - src.doo','Offset',4*4,...   'Writable', true,
    'Format',{'uint8',[50 1],'trees'},'Repeat',1);
B = m.Data.trees;
fprintf('Tree ID                 : %s\n',char( B(1:4) ) );
fprintf('Tree coordinate(X,Y)    : (%d,%d)\n',typecast(B(9:16), 'single') );
fprintf('Tree number(start at 0) : %d\n',typecast(B(47:50), 'uint32')  ) ;

B(1:4) = uint8('LOth'); % 'LOth = torch
fwrite(fileID, repmat(B,N,1),'uint8');
%%

EOF = [0 0];
fwrite(fileID, EOF,'uint32')
%% =================================================
%ftell(fileID)
fseek(fileID, 16+50-4 - 46, -1);
fwrite(fileID,0:N-1,'uint32',46)
%%
[x,y]=ndgrid(-32:-1,32:-1:1);
B=32*[x(:),y(:)]';
fseek(fileID, 16+8, -1);
fwrite(fileID,B(1:2),'2*float','ieee-le')
fwrite(fileID,B(3:end),'2*float',42,'l')
%% =================================================
fclose(fileID);



