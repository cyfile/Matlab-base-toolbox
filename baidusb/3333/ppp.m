% structure operation
t=1:100;
[AX,H1,H2] = plotyy(t,sin(t),t,cos(t));
set(gca, 'Position', get(gca, 'OuterPosition') - ...
get(gca, 'TightInset') * [-1.1 0 2.2 0; 0 -1.1 0 1.1; 0 0 0 0; 0 0 0 1.1]);

findall(gcf,'type','axes')
x1=get(AX(1));
x2=get(AX(2));

kk=cellfun(@(x,y) isequal(x,y),struct2cell(x1),struct2cell(x2));
names = fieldnames(x1);
%renames=names(~kk);

x1re=rmfield(x1,names(kk));
x2re=struct;
for n=names(~kk)'
x2re.(n{:})=x2.(n{:});
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cx1=struct2cell(get(AX(1)));
cx2=struct2cell(get(AX(2)));

kk=cellfun(@(x,y) isequal(x,y),cx1,cx2);
names=fieldnames(x1);
renames=names(~kk);

     cx1{~kk}
     cx2(~kk)

sx1_n=cell2struct(cx1(~kk),renames)
sx2_n=cell2struct(cx2(~kk),renames)
%%%%%%%%%%%%%%%%%%%%
kkk=ismember(names,renames);
isequal(~kk,kkk)
%%%%%%%%%%%%%%%%%%%%%%%%
%axes(AX(1))
axis tight
set(gcf,'CurrentAxes',AX(2))
%axes(AX(2))
axis tight

%
set(AX(1),'color','none')

 

%%%%%%%%%%%%%%%%%%%%%%%

我依稀记得matlab帮助文档里有一个

将get函数得到的structure转换成cell后进行后续操作的例子

我今天遇到了关于structure的问题，很想找到那个例子看看，

却想不起来那个例子是哪一块的了，

我把这件事写下来，希望以后可以再遇到她