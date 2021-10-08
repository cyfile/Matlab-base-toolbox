% Application Data\MathWorks\MATLAB\R2014a\shortcuts_2.xml
<?xml version="1.0" encoding="utf-8"?>
<FAVORITESROOT version="2">
  
  
  
  
  
  
  
  
  
   <title>我的快捷方式</title>
  
  
  
  
  
  
  
  
  
   <FAVORITECATEGORY>
     
     
     
     
     
     
     
     
     
      <name>Help Browser Favorites</name>
  
  
  
     
     
     
     
     
     
      <FAVORITE>
        
        
        
        
        
        
         <label>Operator Precedence</label>
        
        
        
        
        
        
         <icon>Help icon</icon>
        
        
        
        
        
        
         <callback>web(fullfile(docroot, 'matlab/matlab_prog/operator-precedence.html'))</callback>
        
        
        
        
        
        
         <editable>true</editable>
     
     
     
     
     
     
      </FAVORITE>
     
     
     
     
     
     
      <FAVORITE>
        
        
        
        
        
        
         <label>Text Properties</label>
        
        
        
        
        
        
         <icon>Help icon</icon>
        
        
        
        
        
        
         <callback>web(fullfile(docroot, 'matlab/ref/text_props.html#String'))</callback>
        
        
        
        
        
        
         <editable>true</editable>
     
     
     
     
     
     
      </FAVORITE>
  
     
     
     
     
     
      <FAVORITE>
        
        
        
        
        
         <label>Data Types</label>
        
        
        
        
        
         <icon>Help icon</icon>
        
        
        
        
        
         <callback>web(fullfile(docroot, 'matlab/data-types_data-types.html'))</callback>
        
        
        
        
        
         <editable>true</editable>
     
     
     
     
     
      </FAVORITE>
  
     
     
     
     
      <FAVORITE>
        
        
        
        
         <label>Figure Properties</label>
        
        
        
        
         <icon>Help icon</icon>
        
        
        
        
         <callback>web(fullfile(docroot, 'matlab/ref/figure_props.html#Renderer'))</callback>
        
        
        
        
         <editable>true</editable>
     
     
     
     
      </FAVORITE>
  
  
  
  
   </FAVORITECATEGORY>

  
  
  
  
  
  
  
  
   <FAVORITE>
     
     
     
     
     
     
     
     
      <label>2c</label>
     
     
     
     
     
     
     
     
      <icon>Number 2</icon>
     
     
     
     
     
     
     
     
      <callback>clear&#xD;
clc</callback>
     
     
     
     
     
     
     
     
      <editable>true</editable>
  
  
  
  
  
  
  
  
   </FAVORITE>
  
  
  
  
  
  
  
  
   <FAVORITE>
     
     
     
     
     
     
     
     
      <label>closeall</label>
     
     
     
     
     
     
     
     
      <icon>Upper Case X</icon>
     
     
     
     
     
     
     
     
      <callback>%close all&#xD;
close(allchild(0))&#xD;
tmp=allchild(0);&#xD;
if ~isempty(tmp)&#xD;
    disp(['delete ',num2str(length(tmp)),' hidden figures'])&#xD;
    delete(tmp)&#xD;
    beep&#xD;
end&#xD;
clear tmp</callback>
     
     
     
     
     
     
     
     
      <editable>true</editable>
  
  
  
  
  
  
  
  
   </FAVORITE>

  
  
  
  
  
  
  
   <FAVORITE>
     
     
     
     
     
     
     
      <label>newfigure</label>
     
     
     
     
     
     
     
      <icon>Upper Case F</icon>
     
     
     
     
     
     
     
      <callback>jFrame = get(figure,'JavaFrame');&#xD;
pause(0.01)&#xD;
jFrame.setMinimized(true);&#xD;
clear jFrame</callback>
     
     
     
     
     
     
     
      <editable>true</editable>
  
  
  
  
  
  
  
   </FAVORITE>

 

 

 

</FAVORITESROOT>

 