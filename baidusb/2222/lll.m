% graphshortestpath
graph theory        图论

directed graph    有向图

strongly or weakly connected  强连通弱连通
omorphism 同构
directed acyclic graph 有向无环图 dag 有向无环图

undirected graph  无向图

weighted graph    加权图

shortest path   最短路径

Minimum spanning tree 最小生成树

connectivity (connected graph) 连通性（图）



图论总结(超强大)

http://wenku.baidu.com/link?url=0dPOAppCV3R6pWZFBiKlwKZLDGGTC-eTxYKNgfdpW9N0IGvPhZE2V9KOnpM_S-C59x-RC6F8vtvy2tEXRxYokpJ3tsuXs9OpQw7Vr3qjice





%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 

%% graphshortestpath
% doc graphshortestpath

%% Finding the Shortest Path in a Directed Graph
% DESCRIPTIVE TEXT
a=randi(9,9)-1;
b=tril(triu(a,1),3);

bgh=biograph(b,'a':'i','ShowWeights','on');
h = view(bgh);
%isequal(bgh,h)

[dist,path,pred] = graphshortestpath(sparse(b),1,9);

set(h.Nodes(path),'Color',[1 0.4 0.4])
edges = getedgesbynodeid(h,get(h.Nodes(path),'ID'));
set(edges,'LineColor',[1 0 0])
set(edges,'LineWidth',1.5)
%% Finding the Shortest Path in an Undirected Graph
% DESCRIPTIVE TEXT
a=randi(9,9);
b=tril(triu(a,-4),-1);%无向图自动忽略上三角
b(b>7)=0;

h = view(biograph(b,'1':'9','ShowArrows','off','ShowWeights','on'));

[dist,path,pred] = graphshortestpath(sparse(b),1,9,'directed',false);
%This results in the upper triangle of the sparse matrix being ignored
%doc graphshortestpath

set(h.Nodes(path),'Color',[1 0.4 0.4])
fowEdges = getedgesbynodeid(h,get(h.Nodes(path),'ID'));
revEdges = getedgesbynodeid(h,get(h.Nodes(fliplr(path)),'ID'));
edges = [fowEdges;revEdges];
set(edges,'LineColor',[1 0 0])
set(edges,'LineWidth',1.5)

 