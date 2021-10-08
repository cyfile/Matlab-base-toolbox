% 比较cell struct 的异同
aa=get(0,'factory');
bb=fieldnames(aa);
regexp(bb,'.+Fcn$','once','match')
cc=strfind(bb,'Fcn');
dd=~cellfun(@isempty,cc);
ee=bb(dd);
cellfun(@(x) getfield(aa,x),ee,'un',0)

 

%%%%%%%%%%%%%%%%%%%%%%

对于
rrr={[2] [3,4] [5] ones(3,3,3)}
rult={[3,4] [5] [6] ones(3,3,3)}
我有一种解决办法：
setxor(cellfun(@(x) mat2str(x(:)),rrr,'un',0),cellfun(@(x) mat2str(x(:)),rult,'un',0))

 

--------------------------------------------------

%%%%%%      使用cell比较两个结构体的不同 %%%%%%%%%%%%%

kk=get(gca);
kk2=get(gca);
a=fieldnames(kk);
b=cellfun(@(x) isequal(getfield(kk,x),getfield(kk2,x)),a);
c=find(b==0);
%%
k=6;
a{c(k)},getfield(kk,a{c(k)}),getfield(kk2,a{c(k)})
%%

%%%%%%     使用cell和table比较两个结构体的不同   %%%%%%%%%%%%

y = [90,75,30,60,5,40,40,5];
figure
pareto(y)
%%
axs=findall(gcf,'type','axes');%tmp=allchild(gcf),get(tmp,'type');

%%
axsStruct=get(axs);%a=[get(axs(1));get(axs(2))];

% struct2table(get(axs(1)),'asarray',true)
% struct2table(axsStruct,'RowNames',{'axis1','axis2'})

axsStructName=fieldnames(axsStruct);
axsCell=struct2cell(axsStruct);
iaxs=~cellfun(@isequal,axsCell(:,1),axsCell(:,2));
cell2table(axsCell(iaxs,:),'RowNames',axsStructName(iaxs),'VariableNames',{'axis1','axis2'})


%%
ax=findall(gcf,'Yaxislocation','right');
set(ax,'visible','off');

--------------------------------------------------

%%%%%%%%%%%%%%%%%%%%

edit pendan;第208 209行

t = evalin('base','t','[]');
y = evalin('base','y','[]');