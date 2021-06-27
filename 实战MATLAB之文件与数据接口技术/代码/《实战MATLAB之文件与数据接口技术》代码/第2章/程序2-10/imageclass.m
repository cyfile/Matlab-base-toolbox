%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 2-10 imageclass.m
% 保存为imageclass.m文件
classdef imageclass < handle
    properties
        img
        map    
        hf
        himg
        hslider
    end
    methods (Access = private)
         function [obj] = initimg(obj)
            timg = obj.img;            
            timg = double(timg);
            timg = timg/max(timg(:));
            timg = timg*size(obj.map,1);
            obj.img = timg;
            obj.hf = figure;
            obj.himg = imshow(obj.img,obj.map);
            pos = get(obj.hf,'position');
            width = pos(3);
            posgca = get(gca,'position');
            pos(1) = round(posgca(1)*pos(3)); pos(2) = 20;
            pos(3) = round(posgca(3)*pos(3)); pos(4) = 20;
            obj.hslider = uicontrol( 'style', 'slider', 'position', pos);
            set(obj.hslider, 'Value',0.5, 'Callback', @(src,event)slidercallback(obj,src,event));
            uicontrol('style', 'text', 'string', 'dark', 'position', [max(pos(1)-50,1) 20 min(50,pos(1)) 20]);
            uicontrol('style', 'text', 'string', 'bright', 'position', [pos(1)+pos(3) 20 min(50,width - pos(1)-pos(3)) 20]);
         end
         function updateimg(obj,src)
            set(obj.himg,'CData',obj.img);
            colormap(obj.map);
            v = get(src,'Value');
            v = (v-0.5)*2;
            brighten(v);
        end
    end
    methods        
        function [obj] = imageclass(img,map)
            if nargin==0
                in = load('trees');
                img = in.X;
                map = in.map;
            end
            if nargin==1
                map = gray(255);
            end
            obj.img = img;
            obj.map = map;
            obj = initimg(obj);
        end       
        function obj = updateimgdata(obj,timg,map)
            timg = double(timg);
            timg = timg/max(timg(:));
            timg = timg*size(obj.map,1);
            obj.img = timg;
            if nargin==3
                obj.map = map;
            end
            updateimg(obj,obj.hslider);
        end
    end    
    methods
        function [] =slidercallback(obj,src,event)
           updateimg(obj,src);
        end       
        function [] = delete(obj)
            if ishandle(obj.hf)
                close(obj.hf);
            end
        end
    end
end
