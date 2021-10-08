% 正则表达式 匹配合法email地址
%% 测试集,欢迎大家补充
emailStrAll={'ilovematlab123@gmail.com', ...%合法
    'ilovematlab123@gmail.com.cn',...%合法
    'ilove.matlab@gmail.com.cn',...%合法
    'ilove_matlab@gmail.com',... %合法
    'ilove_matlab@gmail-123.com',... %合法
    'ilovematlab.@gmail.com', ...%以下全部是不合法，欢迎大家补充
    '_ilovematlab@gmail_com', ...
    'ilovematlab@@gmail.com', ...
    'ilovem@matlab@gmail.com', ...
    'ilovema&tlab@gmail.com.cn', ...
    'ilovematlab@gmail', ...
    'ilovematlab@gmail.', ...
    'ilovematlab@.gmail', ...
    'ilovematlab@i-com'};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 方法二
string=emailStrAll;
%string='ilovemat_la.b123@Gmai-l.com';
%(1)@前----a仅由\w和\.组成，b首尾仅由字母数字构成，c内部没有连续的_\.
%(2)@----有且仅有一个@符号
%(3)@后到@后的第一个\.----a仅由[a-zA-Z0-9\-]组成，b首尾仅由字母数字构成，c内部没有连续的-
%(4)@后的第一个\.----有且仅有一个
%(5)@后的第一个\.以后----a仅由[a-zA-Z0-9\-.]组成，b首尾仅由字母数字构成，c内部没有连续的-\.
expressn=['^[a-z0-9]+(?:[_.][a-z0-9]+)*@'...   %满足(1)(2)
    '[a-z0-9]+(?:\-[a-z0-9]+)*\.'...           %满足(3)(4)
    '[a-z0-9]+(?:[\-.][a-z0-9]+)*$'];          %满足(5)
%相较帖子里的假设，这里主要是增加了一条：
%出现连续的-_\.时，认为不合法
isvaild=regexpi(string,expressn);
%%
reslstr={'合法','不合法'};
disp([emailStrAll',cellfun(@(x) reslstr(isempty(x)+1),isvaild)'])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 一些命令作为分割
string='ilov.em$at.@.la._b123G.mai-l.com';
regexp(string, '[@.]','split')
D=textscan(string,'%s','Delimiter','@.');
D{1}'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 方法一
string='ilov.em$at.@.la._b123G.mai-l.com';
string=emailStrAll{14};
C=textscan(string,'%s','Delimiter','@');
if size(C{1},1)==2
    b=cellfun(@(x)textscan([x,'.'],'%s','Delimiter','.'),C{1});
    %PS=cell2struct(C{1},{'prefix','suffix'},1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %@前是否含有非法字符
    flag(1)=any(regexp([b{1}{:}],'[^\w]'));
    %@后是否含有非法字符
    flag(2)=any(regexp([b{2}{:}],'[^a-zA-Z\-0-9]'));
    %%%
    % %     %判断是否存在连续的'.'   或是出现在开头和结尾的'.'
    % %     flag(4)=any(cellfun(@isempty,cat(1,b{:})));
    %%%
    % 判断是否存在连续的'.'   或是出现在开头和结尾的非法字符
    try
        flag(3)=any(cellfun(@(x) any(regexp(x([1,end]),'[^a-zA-Z0-9]')),cat(1,b{:})));
    catch err
        flag(3)=1;
    end
    % 判断@后是否有.
    flag(4)=size(b{2},1)<=1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if all(~flag)
        disp('vaild email address')
    else
        disp('invaild')
        disp(['flag:',mat2str(flag)])
    end
else
    disp('the number of ''@'' signs is not equal to one')
end