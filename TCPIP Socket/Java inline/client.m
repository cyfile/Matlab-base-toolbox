% CLIENT connect to a server and read a message
%
% Usage - result = client(host, port, number_of_retries)
function result = client(host, port )
import java.net.Socket
import java.io.*

% input_socket = [];
% message      = [];

for retry = 1:3
    try
        fprintf(1, '  [[[[[[[   Retry %d connecting to %s:%d   ]]]]]]\n', ...
            retry, host, port);
        % throws if unable to connect
        input_socket = Socket(host, port);
        
        % get a buffered data input stream from the socket
        input_stream   = input_socket.getInputStream;
        d_input_stream = DataInputStream(input_stream);
        
        output_stream   = input_socket.getOutputStream;
        d_output_stream = DataOutputStream(output_stream);
        
        %% %%%%%%%%%%%%
        for conntry = 1:5
            
            fprintf(1, [ ' ----  ---- 第 ', num2str(conntry) ,'/5 条信息----  ---- \n']);
            
            st = num2str(randi(9,1,randi(9)));
            message = ['(' num2str(retry) '-' num2str(conntry) ')' st(1:3:end)];
            
            d_output_stream.writeBytes( message );
            d_output_stream.flush;
            
            fprintf(1, [ '                     ', message , ' <<<< Client\n']);
            
            % read data from the socket - wait a short time first
            pause(0.5);
            bytes_available = input_stream.available;
            if bytes_available>0
                
                receivemessage = zeros(1, bytes_available, 'uint8');
                for i = 1:bytes_available
                    receivemessage(i) = d_input_stream.readByte;
                end
                
                result = char(receivemessage);
                fprintf(1, [' server >>>> ' , result , '\n'] );
                
            end
            %% %%%%%%%%%%%%
            % pause(1);
        end
        
        % cleanup
        input_socket.close;
        fprintf(1, '  ======== 本次通信完成 ========\n\n' );
        
    catch ME
        if ~isempty(input_socket)
            input_socket.close;
        end
        disp( ME.ExceptionObject.getMessage );
        % pause before retrying
        pause(1);
    end
end
end