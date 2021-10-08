% miscellaneous
logo

 

输入-help，会出现一大堆数字

 

 

help(cd)

help(pwd)

a=dir

b=ls

c=what

getfield(what, 'm')

 

str = clipboard('paste');

pretty(s)

 

uisetcolor

uistack(h1,'top')

 

realmax

 

mode

 

a=zeros(3,4);

a(:)=1:2:3*4*2;

b=2:5;

b(ones(3,1),:)

 

set(gca, 'Position', get(gca, 'OuterPosition') - ...
get(gca, 'TightInset') * [-1.1 0 2.2 0; 0 -1.1 0 1.1; 0 0 0 0; 0 0 0 1.1]);

 

if any(m==[0 1 5])

 

open db

(line 64):

% We want to guarantee that the result is an integer
% if X is a negative power of 10.  To do so, we force
% some rounding of precision by adding 300-300.

Y = (10.*log10(X)+300)-300;

 

a(abs(a)>max)=max;%饱和 削波
a=fix(a*k)/k;%死区 中心削波
a=double(uint8(a));%饱和加死区

 

if isa(I, 'double') || isa(I,'single')
  fullRange = [0 1];
else
  fullRange(1) = I(1);         %copy class of the input image
  fullRange(1:2) = [-Inf Inf]; %will be clipped to min and max
  fullRange = double(fullRange);
end

 

if a==b,c=d,else c=f,end

c=(a==b)*d+(a~=b)*f

 

a(3:4,2:3)=1

a(sub2ind(size(a),3:4,2:3))=2

 

tabulate

 

 set(Pipe1,'children',h)
Error using set
Children may only be set to a permutation of itself

%handle 的children属性是可以被设置的，但不能给对象添加新的children，只能改变对象已有children的存储显示顺序

uistack

 

数据类型的自动变换

a=[1 1],a(2)='3'

b(2)='3',b(1)

-help

 

c = hypot(a,b)

 

helpview([docroot '/mapfiles/simulink.map'], 'customize_gui')

 

%%%%%%%%%%%%%%%%%%%%%%%

b=plot(sin(1:.1:10)),set(b,'LineSmoothing','on')