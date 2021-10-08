function newbytesdisp(netObj,event)
%%%
disp(['  --- trigger new BytesAvailable callback ---  累计接收数据',...
    num2str(netObj.ValuesSent),'bytes']);
% disp(strcat('累计接收数据',num2str(netObj.ValuesSent),'bytes'));
%查看接收的数据
nBytes = get(netObj,'BytesAvailable');
if nBytes>0
%     data = fread(netObj,nBytes/2,'int16');
    data = fread(netObj,nBytes,'uint8')';
    disp('新接收到的数据为:');
    txt = char(data);
    disp(txt);
%     disp(arrayfun(@string,txt));
    disp(string(txt')')
    disp(string(dec2hex(data))')
else
    disp('数据已经被全部读取,没有更多数据');
end
 