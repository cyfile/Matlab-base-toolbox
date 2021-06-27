% SERVER Write a message over the specified port
%
% Usage - server(message, output_port, number_of_retries)
function server(message)
import java.net.ServerSocket
import java.io.*

output_port=3000;
number_of_retries = 3; % set to -1 for infinite

retry             = 0;
comtry = 0;
server_socket  = [];
output_socket  = [];
%% %%%%%%%%%%%%%%%%%%%%%%

while true
    retry = retry + 1;
    try
        if ((number_of_retries > 0) && (retry > number_of_retries))
            fprintf(1, 'Too many retries\n');
            break;
        end
        fprintf(1, ['Try %d waiting for client to connect to this ' ...
            'host on port : %d\n'], retry, output_port);
        % wait for 2 second for client to connect server socket
        server_socket = ServerSocket(output_port);
        server_socket.setSoTimeout(2000);
        output_socket = server_socket.accept;
        fprintf(1, '        Client connected        \n');
        %% %%%%%%%%%%%%
        
        input_stream   = output_socket.getInputStream;
        d_input_stream = DataInputStream(input_stream);
        
        output_stream   = output_socket.getOutputStream;
        d_output_stream = DataOutputStream(output_stream);
        %% %%%%%%%%%%%%
        while true
            
            comtry = comtry + 1;
            fprintf(1, [ ' ----  ---- ', num2str(comtry) ,' ----  ---- \n']);
            if (comtry > 10 )
                fprintf(1, 'wait info for 10 times\n');
                break;
            end
            bytes_available = input_stream.available;
            if bytes_available>0
                srecv( d_input_stream ,bytes_available)
                
                message = repmat( [num2str(comtry), '>>>>'] , 1,4 );
                ssend( d_output_stream ,message)
                break
            end
            %% %%%%%%%%%%%%
            pause(1);
        end
        
        
        %% %%%%%%%%%%%%
        % clean up
        server_socket.close;
        output_socket.close;
        break;
        
    catch ME
        if ~isempty(server_socket)
            server_socket.close
        end
        if ~isempty(output_socket)
            output_socket.close
        end
        % pause before retrying
        disp( ME.ExceptionObject.getMessage );
        % rethrow(ME)
        pause(1);
    end
end
end