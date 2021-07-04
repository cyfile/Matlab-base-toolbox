% problem2.m
%%%%%%%%%%%%%%
%问题二模型
%%%%%%%%%%%%%%
importdata;
%------------
mark1=sum([redscore1g,redscore2g],2);
mark2=sum(mainredgrapetarget,2);
mark3=sum(mainredgrapefrag,2);
A=[mark1,mark2,mark3];
% A=[mark1,mark2];

x=A;
x=zscore(x); 
y=pdist(x); 
z=linkage(y,'complete');
dendrogram(z)
xlabel('红葡萄样本标号')

redT = cluster(z,'maxclust',3);
find(redT==1)
find(redT==2)
find(redT==3)

% B=[whitescore1g,whitescore2g,mainwhitegrapetarget,mainwhitegrapefrag];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mark1=sum([whitescore1g,whitescore2g],2);
mark2=sum(mainwhitegrapetarget,2);
mark3=sum(mainwhitegrapefrag,2);
B=[mark1,mark2,mark3];
% B=[mark1,mark2];

x=B;
x=zscore(x); 
y=pdist(x); 
z=linkage(y,'complete');
figure
dendrogram(z)
xlabel('白葡萄样本标号')

whiteT = cluster(z,'maxclust',3);
find(whiteT==1)
find(whiteT==2)
find(whiteT==3)