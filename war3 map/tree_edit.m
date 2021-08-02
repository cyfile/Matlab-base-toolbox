m = memmapfile('war3map.doo',...
    'Format',{'uint32',4,'Header'},'Repeat',1);
A = m.Data.Header;
fprintf('file ID         : %s\n',char( typecast(A(1), 'uint8') ));
fprintf('file version    : %d\n',A(2) );
fprintf('subversion?     : %d\n',A(3) ) ;
fprintf('number of trees : %d\n',A(4) );
%%
% Each tree is defined by a 50 bytes block(file version: 8, subversion: 11)
m = memmapfile('war3map.doo','Offset',4*4,'Writable', true,...
    'Format',{'uint8',[50 80],'trees'},'Repeat',1);
A = m.Data.trees;
fprintf('Tree ID                 : %s\n',char( A(1:4) ) );
fprintf('Tree coordinate(X,Y)    : (%d,%d)\n',typecast(A(9:16), 'single') );
fprintf('Tree number(start at 0) : %d\n',typecast(A(47:50,2), 'uint32')  ) ;
;
char(A(1:4))
A(9:16,1:80)=;
m.Data.units=A;
%% =================================================
return
%% =================================================
fileID = fopen('war3map.doo','r');

t_beg=fread(fileID,12,'uint8=>uint8');
t_begx=fread(fileID,4,'uint8=>uint8');
t_sam1=fread(fileID,8,'uint8=>uint8');
t_samx=fread(fileID,8,'uint8=>uint8');
t_sam3=fread(fileID,30,'uint8=>uint8');
t_end=uint8(zeros(8,1));
%doo=fread(fileID,Inf,'float=>double',46);
fclose(fileID);

%[xx2,yy2]=meshgrid( -128*8:64:8*128 );
[xx2,yy2]=meshgrid( 0:64:2*112*64 );
xx=xx2(~~D);
yy=yy2(~~D);
aa=length(xx);
id=1:1:aa;
%%

fileID = fopen('war3map.doo','w');%
    fwrite(fileID, t_beg);
    fwrite(fileID, aa, 'int', 'ieee-le');
for k=id
    fwrite(fileID, t_sam1);
    fwrite(fileID, xx(k), 'float','ieee-le');
    fwrite(fileID, yy(k), 'float','ieee-le');
    fwrite(fileID, t_sam3);
    fwrite(fileID, k-1, 'int','ieee-le');
end
    fwrite(fileID, t_end);

%ftell(fileID)
%fseek(fileID, 12, -1);
%ftell(fileID)
    
fclose(fileID)

%%
return

