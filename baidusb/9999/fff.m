% Private Function

function k=aaa
a=2
k{a}=bbb

function c=bbb
a=5    %主函数里的的a的值会在这被改变
c=1
end
end     %end 放到最后
%%%%%%%%%%%%%%%%%%
%上下两端程序主函数end的位置不同
%%%%%%%%%%%%%%%%%%
function k=aaa
a=2    %主函数里的的a的值会在这被改变
k{a}=bbb
end     %end 放到这里
function c=bbb
a=5     %这是另外一个函数的a值，和主函数里的a不是一个变量
c=1
end