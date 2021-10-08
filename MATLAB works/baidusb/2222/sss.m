% matlab启动时间
%%%%%%%%%%%%%%%%

%   一个显示matlab开始启动时间的批处理文件

::冒号是建立标签(供以后调用?),双冒号是建立一个无法被调用的标签,

: 冒号加空格是建立一个没名的标签,所以他们都可以来写注释

echo off & cls

::上一行是echo命令和cls命令写到一行去了

echo %time%

::显示系统自带的动态变量time,

::更多系统自带的动态变量可以察看cmd下set的帮助文档,运行 set /?

::cd /d F:\mywork
matlab -nosplash -sd F:/mywork

::运行matlab,所以这个批处理要放在matlab快捷方式同一目录下

echo 按任意键退出
pause >nul
: & exit
: %0

%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%

在 matlabrc头部 输入

tic

在 matlabrc尾部 或是 startup 中输入

toc

datestr(now, 'hh:MM:SS FFF')

 %%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%

创建matlab的shortcut：

datestr(now, 'hh:MM:SS FFF')

matlab启动之后迅速单击。% -_-!