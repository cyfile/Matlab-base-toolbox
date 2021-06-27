
function ssend( d_output_stream , message)
% output the data over the DataOutputStream
% Convert to stream of bytes

%responsemessage =[ 'HTTP/1.1 200 OK',char([13 10 13 10]),'<!DOCTYPE html><!--STATUS OK--><html><head></head><body>sometext</body></html>']
responsemessage =[ 'HTTP/1.1 200 OK',char([13 10 13 10]), message ];

d_output_stream.writeBytes(char(responsemessage));
d_output_stream.flush;
fprintf(1, ' ------ Have written %d bytes\n', length(responsemessage))