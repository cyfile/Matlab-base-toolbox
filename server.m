% SERVER Write a message over the specified port
%
% Usage - server(message, output_port, number_of_retries)
function server(message)
import java.net.ServerSocket
import java.io.*

output_port=3000;

% server_socket  = [];
output_socket  = [];
%% %%%%%%%%%%%%%%%%%%%%%%
server_socket = ServerSocket(output_port);
% wait for 20 second for client to connect server socket
server_socket.setSoTimeout(20000);

try
    for conntry = 1:5
        fprintf(1, ['Try %d waiting for client to connect to this ' ...
            'host on port : %d\n'], conntry, output_port);
        output_socket = server_socket.accept;
        fprintf(1, '        Client connected        \n');
        
        %% %%%%%%%%%%%%
        input_stream   = output_socket.getInputStream;
        d_input_stream = DataInputStream(input_stream);
        
        output_stream   = output_socket.getOutputStream;
        d_output_stream = DataOutputStream(output_stream);
        %% %%%%%%%%%%%%
        
        for sesstry = 1:3
            fprintf(1, [ ' ----  ---- session: ', num2str(sesstry) ,'/3 ----  ---- \n']);

            bytes_available = input_stream.available;
            if bytes_available>0
                info = srecv( d_input_stream ,bytes_available)
                
                if info == 0
                    message = repmat( [num2str(sesstry), '>>>>'] , 1,4 );
                else
                    k = load('a.mat','a');
                    message = k.a;
                end
                ssend( d_output_stream ,message)
                break
            end
            %% %%%%%%%%%%%%
            pause(0.8)
        end
        output_socket.close;
        disp('connect closed')
        %break;
    end
    
catch ME
    
    if ~isempty(output_socket)
        output_socket.close
    end
    disp( ME.ExceptionObject.getMessage );
    
end
server_socket.close
disp('server closed')
