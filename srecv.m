function request = srecv(d_input_stream , bytes_available)
%%

requestmessage = zeros(1, bytes_available, 'uint8');
for i = 1:bytes_available
    requestmessage(i) = d_input_stream.readByte;
end
if requestmessage(6) == uint8(' ')
    request = 0;
else
    request = 1;
end
    
disp( [char(requestmessage(1:min(40,bytes_available) )),'    ...'] );
fprintf(1, ' ------ Have receive %d bytes\n', bytes_available);
