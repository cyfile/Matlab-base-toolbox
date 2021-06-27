function bbbb(obj,event)
net = obj;
 s = struct( 'RecordStatus', net.RecordStatus, ...
     'TransferStatus', net.TransferStatus, 'BytesAvailable', net.BytesAvailable, ...
     'ValuesReceived', net.ValuesReceived, 'ValuesSent', net.ValuesSent)
%str = char(fread(net,net.BytesAvailable))'


% data = fread(net,nBytes/2);
% char(data(1:10)')
% string(dec2hex(data(1:10)))'

end