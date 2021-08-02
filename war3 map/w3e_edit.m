m = memmapfile('war3map.w3e',...
    'Format',{'uint8',[1 4],'marker';...
    'uint32',1,'version';...
    'uint8',1,'tileset'},'Repeat',1);
A = m.Data;
char(A.marker), A.version % version 11
char(A.tileset)  % L = 	Lordaeron Summer
%%
m = memmapfile('war3map.w3e','Offset',9,...
    'Format',{'uint8',4,'x'},'Repeat',15);
A = m.Data;

fprintf('ground tilesets ID    : %s\n',char(A(3).x));
fprintf('ground tilesets ID    : %c%c%c%c\n',A(11).x);
Mx = typecast(A(12).x, 'uint32');
My = typecast(A(13).x, 'uint32');
tilepoints = double([7,Mx*My]);
fprintf('width & height of map : %dx%d\n',Mx , My) ;
fprintf('bottom left coordinate: %dx%d\n',...
    typecast(A(14).x, 'single'),...
    typecast(A(15).x, 'single'));

%%
tilepoints = [7 193*193];
m = memmapfile('war3map.w3e','Offset',15*4+9,'Writable', true,...
    'Format',{'uint8',tilepoints,'tile'});
A = m.Data.tile;

map = 128*isBoundary + groundType ;
A(5,:)= map(:);
m.Data.tile = A;

%% =================================================
return
%% =================================================
fileID = fopen('war3map.w3e','r');
w3e=fread(fileID,'uint8');
fclose(fileID);
%%
ind=((69+5):7:length(w3e));
%(length(w3e)-69)/7/225

isBoundary=isBoundary(:);
groundType=groundType(:);
%return
for k = 1:size(isBoundary,1)
    if isBoundary(k)==1
        w3e(ind(k))=bitor(w3e(ind(k)),128);
    end
    
    if groundType(k)>=1
        w3e(ind(k))=w3e(ind(k))+groundType(k);
    end
end
%%
fileID = fopen('war3map.w3e','w');%
fwrite(fileID, w3e)
fclose(fileID)