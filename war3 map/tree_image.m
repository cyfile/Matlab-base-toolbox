tree_image_player
tree_image_ring
tree_image_neutral
tree_image_kernel
%%
% TREE = treeP | treeR | treeN | treeK;
TREE = treeP | treeR | treeN;
[sum(treeP(:)),sum(treeR(:)),sum(treeN(:))]
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




