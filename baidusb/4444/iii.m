% Éú³É¸ñÀ×Âë generate garycode
b=[0;1]
garycode=b;
for k=1:3
    garycode=[kron(b,ones(2^k,1)),[garycode;flipud(garycode)]];
end

%%%%%%%%%%%%

order=16;
j = (0:order-1)';
mapping = bitxor(j,bitshift(j,-1));