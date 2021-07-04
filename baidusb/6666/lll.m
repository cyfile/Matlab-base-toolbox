% 算法洗脑系列（8篇）——第四篇 枚举思想(matlab) 02.png
填写数字的模板，其中每个字都代表数字中的”0~9“，那么要求我们输入的数字能够满足此模板。




        

clear  
k=0;  
lop=1;  
t=0;  
while lop&&t<10
    t=t+1;  
    for s=1:9
        k=k+1;  
        if mod(t*111111,s)==0
            tmp=num2str(t*111111/s)-'0';  
            if tmp(1)==s&tmp(end)==t  
                if length(unique(tmp))==5
                 k,tmp  
                 lop =0;  
                 break
                end  
            end  
        end  
    end  
        
end