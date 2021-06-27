%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 2-5 testnarin_out.m
% 保存为testnarin_out.m文件
function [varargout]=testnargin_out(varargin)
% function [varargout]=testnargin_out(m,n,k)
% testnarin_out.m
disp('输入参数的个数');
disp(nargin);
disp('输出参数的个数');
disp(nargout);
if(nargout>nargin)
    error('输出参数的个数不能大于输入参数的个数!\n');
end
varargout{1:nargout} = varargin{1:nargout};
