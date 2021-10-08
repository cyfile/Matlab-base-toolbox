a=192;
[x,y]=meshgrid( (-a:a)*64 );
v = x+1i*flipud(y);
%%
% m =54;

C=zeros(2*a+1);

for k=0:19
    A=zeros(2*a+1);
    z = k*18 ;
    for r = 53*128 : 64 : 55*128    % (m-1)*128 : 64 : (m+1)*128
        x = r *cosd(z) ;
        y = r *sind(z) ;
        A( abs(v-x-1i*y)<11*64 ) =1;
    end
    
    r = 51*128;
    x = r *cosd(z) ;
    y = r *sind(z) ;
    A( abs(v-x-1i*y)<4*64 ) =0;
    
    r = 46*128;
    x = r *cosd(z) ;
    y = r *sind(z) ;
    A( abs(v-x-1i*y)<8*64 ) =0;
    
    A( abs(v+32+32i)>54*128+64 )=0;    %%%%%% bias
    
    [B,r] = tree_FCN_optim( A );
    r;
    C = C | B;
end
%% ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
% figure
imshow(C)
sum(C(:))
%
treeR = C ;



