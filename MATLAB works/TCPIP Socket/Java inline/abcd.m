% an  Server / Client example
% call Java inline to perform message communication using TCP/IP.
% https://www.mathworks.com/matlabcentral/fileexchange/21131-tcp-ip-socket-communications-in-matlab

message = char(mod(1:1000, 255)+1);
server(message)
return
%%
!matlab -nosplash -r "abcd" &
data = client('localhost', 3000)
