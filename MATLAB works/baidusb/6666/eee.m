% 算法系列（8篇）——第八篇 概率思想第三篇 贪心思想第七篇 动态规划(matlab)
背包问题

问题相见http://www.mathworks.cn/matlabcentral/contest/contests/3/rules

sum(songList(indexList)) <= mediaLength, and 
gap = (mediaLength - sum(songList(indexList))) / mediaLengthis minimized. 
function indexList = binpack(songList,mediaLength) 
if (nargin == 0) 
    songList=songlis(1); 
    mediaLength=45; 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
[s,t] = sort(songList); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%以概率的思想求得一个较优解↓ 
a = size(s,2); 
b = min(a,round(4*a*mediaLength/sum(s))); 
c = 85+0.09*a; 
%[d,e] = sort(rand(b,c)); 
[d,e] = sort(rand(b,c/4)); 
c=4*size(e,2); 
e = [e flipud(e) e([2:b 1],:) e([3:b 1 2],:)]; 
q = 0.25*(a-b); 
if q > 1
    r = floor(q*rand(1,c)); 
    e = e+r(ones(1,b),:); 
end
f = cumsum(s(e)); 
g = sum(f<=mediaLength); 
[d,h] = max(f(g+(0:b:b*c-b))); 
indexList = t(e(1:g(h),h)); 
%%以概率的思想求得一个较优解↑ 
%%%%%%%%%%%%% 
%%根据贪心思想，确定最终解的元素个数和上述较优解相同↓ 
                        
%%%%%%%%%%%%% 
%%通过动态规划，继续优化较优解，以得到最终解↓ 
leftOff = t(e(g(h)+1:end,h)); 
remTime = mediaLength-d; 
onez1 = ones(1,g(h)); 
onez2 = ones(b-g(h),1); 
newFree = remTime + songList(onez2,indexList) - songList(onez1,leftOff)'; 
newFree(newFree<0) = 9e9; 
[m,i] = min(newFree); 
[m,j] = min(m); 
if m<remTime 
    aux = indexList(j); 
    indexList(j) = leftOff(i(j)); 
    leftOff(i(j)) = aux; 
    newFree = m+songList(onez2,indexList)-songList(onez1,leftOff)'; 
    newFree(newFree<0) = 9e9; 
    [m1,i] = min(newFree); 
    [m1,j] = min(m1); 
    if m1<m 
        aux = indexList(j); 
        indexList(j) = leftOff(i(j)); 
        leftOff(i(j)) = aux; 
        newFree = m1+songList(onez2,indexList)-songList(onez1,leftOff)'; 
        newFree(newFree<0) = 9e9; 
        [m2,i] = min(newFree); 
        [m2,j] = min(m2); 
        if m2<m1 
            indexList(j) = leftOff(i(j)); 
        end
    end
end
                        
%%通过动态规划，继续优化较优解，以得到最终解↑ 
%%%%%%%%%%%%%