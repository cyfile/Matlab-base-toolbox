function [methodinfo,structs,enuminfo,ThunkLibName]=mxproto
% if ~libisloaded(mfilename);
%     loadlibrary('user32.dll',@mxproto,'alias','aaa');
% end
% 
% h = calllib(mfilename,'FindWindowA',[],name);
% calllib(mfilename,'CloseWindow',h);
% unloadlibrary mfilename

structs=[];enuminfo=[];ThunkLibName=[];
ival={cell(1,1)}; % change 0 to the actual number of functions to preallocate the data.

fcns=struct('name',ival,'calltype',ival,'LHS',ival,'RHS',ival); %,'alias',ival);

% fcns.alias={};

%  HWND _stdcall FindWindowA(LPCSTR,LPCSTR); 
% fcns.name{1} = 'FindWindowA';
% fcns.calltype{1} = 'stdcall';
% fcns.LHS{1} = 'voidRef';
% fcns.RHS{1} = {'int8Ref', 'string'};

fcns.name{1} = 'CloseWindow';
fcns.calltype{1} = 'stdcall';
fcns.LHS{1} = 'uint32';
fcns.RHS{1} = {'uint8'};

methodinfo=fcns;