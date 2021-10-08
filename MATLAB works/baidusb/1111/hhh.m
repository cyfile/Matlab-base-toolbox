% xml 文件操作
DOMnode = xmlread(...
    ['https://query.yahooapis.com/v1/public/yql?q=' ...
    'select%20*%20from%20geo.states%20where%20place%3D%22China%22&diagnostics=true']);
xRoot=DOMnode.getDocumentElement;
places_nodes=xRoot.getChildNodes.item(1).getChildNodes;
n=places_nodes.getLength;
R=cell(n,1);
for k=1:n
    names_node=places_nodes.item(k-1).getElementsByTagName('name').item(0);
    R{k}=char(names_node.getFirstChild.getData);
end

%西藏在这里面但台湾不在