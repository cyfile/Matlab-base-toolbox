% dipshudo

function dipsd(A,B)
%display shudo
%
if nargin <1
    A=dlmread('shuju.txt');
end
if nargin <2
    plotframe
end
if nargin ==2
    A=A.*B;
end
if iscell(A)
    A=mrk2mat(A);
end

dipnum(A)
%%%%%%%%%%%%%%%%
    function plotframe
        a=repmat([0 ;3],1,4);
        b=repmat(0:3,2,1);
       
        figure('Toolbar','none');
        plot([b,a],[a,b],'k','LineWidth',2)
        axis equal
        axis off
        hold on
        for m=0.02:1:3
            for n=0.02:1:3
                plot(0.32*[b,a]+m,0.32*[a,b]+n,'k','LineWidth',2)
            end
        end
    end
%--------------------------------------------------
    function dipnum(A)
        [c,d]=find(A);
       
       
        y= 2-floor((c-1)/3)+1-0.32*mod(c-1,3)-0.18;
        x= floor((d-1)/3)+0.32*mod(d-1,3)+0.12 ;
        for k=1:length(c)
           
            text(x(k),y(k),num2str(A(c(k),d(k))),'FontSize',22)
        end
    end
 %%%%%%%%%%%%%%%%%%%
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

doc drawSudoku

doc sudokuEngine

这是很早之前我写的一个数独求解程序的一部分

%%%%%%%%%%%%%%%%%%%%
那个数独求解程序虽然比较复杂，但是与我的水平相较，还算是很高效的
绝对可以用，求解任何数独都没有问题。
可以求多解。


现在发现matlab2014a优化工具箱自带有专门的数独求解程序，
而且还有个专门讨论数独求解的例子
doc('Solve Sudoku Puzzles Via Integer Programming')。
还给出了Cleve Moler 写的使用递归方法求解数独的程序的网页链接
http://www.mathworks.cn/company/newsletters/articles/solving-sudoku-with-matlab.html

于是翻出了这个我自己写的程序。我觉定把这个程序从计算机上删掉，在此之前先把他传到网上，

http://www.ilovematlab.cn/thread-294985-1-1.html

如果以后我有对它感兴趣还可以下载来再看看，不过我觉得这没什么机会了。

这些文件的入口是一个叫 start.m 的函数，这个函数很简单打开后看看就知道怎么使用了