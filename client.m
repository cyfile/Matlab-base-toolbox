% CLIENT connect to a server and read a message
%
% Usage - message = client(host, port, number_of_retries)
function client(host, port )
import java.net.Socket
import java.io.*

    number_of_retries = 3; % set to -1 for infinite


retry        = 0;
comtry = 0;
input_socket = [];
message      = [];
while true
    retry = retry + 1;
    if ((number_of_retries > 0) && (retry > number_of_retries))
        fprintf(1, 'Too many retries\n');
        break;
    end
    
    try
        fprintf(1, 'Retry %d connecting to %s:%d\n', ...
            retry, host, port);
        % throws if unable to connect
        input_socket = Socket(host, port);
        
        % get a buffered data input stream from the socket
        input_stream   = input_socket.getInputStream;
        d_input_stream = DataInputStream(input_stream);
        
        output_stream   = input_socket.getOutputStream;
        d_output_stream = DataOutputStream(output_stream);
        
        %% %%%%%%%%%%%%
        while true
            comtry = comtry + 1;
            fprintf(1, [ ' ----  ---- ', num2str(comtry) ,' ----  ---- \n']);
            if (comtry > 10 )
                fprintf(1, 'send info for 10 times\n');
                break;
            end
            message = repmat( [ '>>>>' , num2str(comtry)] , 1,4 );
            ssend( d_output_stream ,message)
            % read data from the socket - wait a short time first
            pause(0.5);
            bytes_available = input_stream.available;
            if bytes_available>0
                srecv( d_input_stream ,bytes_available)
                
            end
            %% %%%%%%%%%%%%
            pause(1);
        end
        

        % cleanup
        input_socket.close;
        break;
        
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