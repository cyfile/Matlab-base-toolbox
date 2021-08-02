D=zeros(size(C));
c=C;

[I,J] = find(c);
while size(I,1)>0
    %k=randi(size(I,1));
    [~,k]=min(I.*I+J.*J);
    D(I(k),J(k))=1;
    c([I(k)-1,I(k),I(k)+1],[J(k)-1,J(k),J(k)+1])=0;
    [I,J] = find(c);
end

imshow(D)
