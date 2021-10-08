tree_image_player
tree_image_ring
% tree_image_neutral
%%
% TREE = treeP | treeR | treeN ;
TREE = treeK | treeR ;
TREE = treeP | treeR ;
TREE = logical(treeP) ;
[sum(treeP(:)),sum(treeR(:))]
% 3478         902         832
sum(TREE(:))
% imshow(TREE)
%%
a=192/2*128;
[xx,yy]=meshgrid( -a:64:a );
yy = flipud(yy);
treeX=xx(TREE);
treeY=yy(TREE);
treeM=length(treeX);
%
tree_edit




