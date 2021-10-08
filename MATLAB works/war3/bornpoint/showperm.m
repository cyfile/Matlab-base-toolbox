function [fval, check] = showperm(r, flag)
    
    n = length(r);
    
    rx = cos((r-1)*2*pi/n);
    ry = sin((r-1)*2*pi/n);
    
    plot(rx,ry,'-O')
    text(0,0,num2str(r'))
    text(rx,ry,string(r) )
    
    
    axis equal
    
    
end