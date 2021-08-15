function [row,col,r0,c0]=tree_FCN_line(R, Z )

if  mod( Z+45 , 180 )<=90
    xend = 2*round(R * cosd( Z )/128) ;
    yend = round( xend * tand( Z )) ;

    x = [xend+2:2:0,0:2:xend-2] ;
    yy = x * tand( Z );
    y1 = round( yy ) ;
    y2 = y1 + 2*sign( yy-y1 );
    
    row = -[y1,y2,yend];
    col = [x,x,xend];
else
    yend = 2*round(R * sind( Z )/128) ;
    xend = round( yend * cotd( Z ) ) ;
    
    y = [yend+2:2:0,0:2:yend-2] ;
    xx =  y * cotd( Z ) ;
    x1 = round( xx );
    x2 = x1 + 2*sign( xx - x1 );
    
    row = -[y,y,yend];
    col = [x1,x2,xend];
end

r0 = -yend;
c0 = xend;
%% ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ

if false
    %%
    a=192;
    A = zeros(2*a+1);
    A(sub2ind(size(A),a+1 + row, a+1 + col))=1;
    imshow(A)
    %[row,col] = find(A);
    %%
end



