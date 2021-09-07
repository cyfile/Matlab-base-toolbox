a= [ 3605.4, 1144.4, 218.609     
3647.6, 2205.6, 160.421     
4936.8, 1906.3, 19.559      
1940.7, - 204.3, 93.381     
1226.5, - 884.8, 161.061    
2138.4, - 1152.0, - 33.155  
4619.9, 700.4, - 75.638 ];
r= hypot(a(:,1),a(:,2));
z= atand(a(:,2)./a(:,1));
pp = a(:,3)-z;
p = pp-360*fix(pp/180);
A =round([r z p]);
[~,c]=sort(r, 'descend');
B=A(c,:)
C=B(1:4,:);
C(:)
D=B(5:end,:);
D(:)
%%

%%
% ZZZZZZZZZZZZZZZZZZZZZZZZZ
return
% ZZZZZZZZZZZZZZZZZZZZZZZZZ
    
num2hex(single(3904))
num2hex(swapbytes(single(3904)))
typecast(hex2num('44800000'),'single')
typecast(swapbytes(single(3904)),'uint8')

dec2hex(191)
%%


