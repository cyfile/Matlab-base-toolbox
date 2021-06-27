% import java.awt.Robot;
% import java.awt.event.*;
%% 屏幕截图
%scrSize = get(0,'ScreenSize');
x=200;y=200;w=300;h=200;

robot = java.awt.Robot;
I = zeros(w*h*3,1); %创建存储RGB像素信息的double数组
rectangle = java.awt.Rectangle(x,y,w,h);
%%
image = robot.createScreenCapture(rectangle); %创建包含从屏幕中读取的像素的图像
raster = image.getData(); %获取图像RGB数据，返回Raster类的对象
I = raster.getPixels(0,0,w,h,I); %获取图像一维RGB颜色数组
%%
Img = permute(reshape(I,3,w,h),[3,2,1]);
imshow(uint8(Img))
%% 鼠标操作
BUTTON1 =java.awt.event.InputEvent.BUTTON1_MASK;
a = 6;
pause( 10 )

while a>0
pause( 2 )
%set(0,'PointerLocation',[x y]);
robot.mouseMove(100, 20)
robot.mousePress  (BUTTON1);
robot.mouseRelease(BUTTON1);
pause( 2 )
robot.mouseMove(300, 20)
robot.mousePress  (BUTTON1);
robot.mouseRelease(BUTTON1);
a=a-1;
end
% robot.keyPress    (java.awt.event.KeyEvent.VK_ENTER);
% robot.keyRelease  (java.awt.event.KeyEvent.VK_ENTER);


%% 在matlab 窗口画线
% java.awt.Graphics
scrSize = num2cell( get(0,'ScreenSize') );
[x1,y1,x2,y2]=scrSize{:};
aaa=java.awt.DefaultKeyboardFocusManager()
bbb=aaa.getActiveWindow.getComponentAt(20,20)
ccc=bbb.getGraphics
ccc.setColor(java.awt.Color.BLUE),
ccc.drawLine(x1, y1, x2, y2)
ccc.setColor(java.awt.Color.RED),
ccc.drawLine(x1, y2, x2, y1)

%% 使用 jna . 很多函数找不到 也许是我水平不行 总之非常不好用
import com.sun.jna.platform.win32.*
user32dll = com.sun.jna.platform.win32.User32.INSTANCE
gdi32dll = com.sun.jna.platform.win32.GDI32.INSTANCE
% aaa=User32.INSTANCE
hWnd = user32dll.FindWindow('Notepad','Test.txt - 记事本')
%hWnd = user32dll.FindWindow('OsWindow', 'Warcraft III');
hdcWindow = user32dll.GetDC(hWnd)

% 以下有些函数找不到
% hPen = gdi32dll.CreatePen(PS_SOLID, 1, RGB(0, 255, 0))
hPenOld = gdi32dll.SelectObject(hdcWindow, hPen);

% gdi32dll.MoveToEx(hdcWindow, x, y, (LPPOINT)NULL);
% gdi32dll.LineTo(hdcWindow, x + cx, y + cy);
% gdi32dll.MoveToEx(hdcWindow, x + cx , y, (LPPOINT)NULL);
% gdi32dll.LineTo(hdcWindow, x, y + cy);

gdi32dll.SelectObject(hdcWindow, hPenOld);
gdi32dll.DeleteObject(hPen);
% ReleaseDC(hWnd, hdcWindow);