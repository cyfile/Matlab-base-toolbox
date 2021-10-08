if false
    m = memmapfile('war3map - src.doo',...
        'Format',{'uint32',4,'Header'},'Repeat',1);
    A = m.Data.Header;
    fprintf('file ID         : %s\n',char( typecast(A(1), 'uint8') ));
    fprintf('file version    : %d\n',A(2) );
    fprintf('subversion?     : %d\n',A(3) ) ;
    fprintf('number of trees : %d\n',A(4) );
    %%
    % Each tree is defined by a 50 bytes block(file version: 8, subversion: 11)
    m = memmapfile('war3map - src.doo','Offset',4*4,...   'Writable', true,
        'Format',{'uint8',[50 80],'trees'},'Repeat',1);
    A = m.Data.trees;
    fprintf('Tree ID                 : %s\n',char( A(1:4) ) );
    fprintf('Tree coordinate(X,Y)    : (%d,%d)\n',typecast(A(9:16), 'single') );
    fprintf('Tree number(start at 0) : %d\n',typecast(A(47:50,2), 'uint32')  ) ;
end
%% =================================================
copyfile( 'war3map - src.doo', 'war3map.doo')
fileID = fopen('war3map.doo','r');

t_beg=fread(fileID,12,'uint8=>uint8');
t_begx=fread(fileID,4,'uint8=>uint8');
t_sam1=fread(fileID,8,'uint8=>uint8');
t_samx=fread(fileID,8,'uint8=>uint8');
t_sam3=fread(fileID,30,'uint8=>uint8');
t_end=uint8(zeros(8,1));
%doo=fread(fileID,Inf,'float=>double',46);
fclose(fileID);
%%

fileID = fopen('war3map.doo','w');%
fwrite(fileID, t_beg);
fwrite(fileID, treeM, 'int', 'ieee-le');
for k=1:treeM
    fwrite(fileID, t_sam1);
    fwrite(fileID, treeX(k), 'float','ieee-le');
    fwrite(fileID, treeY(k), 'float','ieee-le');
    fwrite(fileID, t_sam3);
    fwrite(fileID, k-1, 'int','ieee-le');
end
fwrite(fileID, t_end);

%ftell(fileID)
%fseek(fileID, 12, -1);

fclose(fileID);



