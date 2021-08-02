

num2hex(single(3904))
num2hex(swapbytes(single(3904)))
typecast(hex2num('44800000'),'single')
typecast(swapbytes(single(3904)),'uint8')

dec2hex(191)
return
%%
fileID = fopen('war3map.w3e','r');
%ftell(fileID)
%fseek(fileID, 24, -1);
%ftell(fileID)

doo=fread(fileID,100,'uint8=>uint8');
fclose(fileID);
%%
%doo
dec2hex(doo)'
