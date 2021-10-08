function boundaryTest(libname)
x1 = 135;x2 = 343;
y1 = 683;y2 = 889;
for a =[0 0 ; -1 1; 1 -1]'
%     a
    calllib(libname,'commandClick',x1+a(1), 800)
    pause(1)
    calllib(libname,'commandClick',200, y1+a(1))
    pause(1)
    calllib(libname,'commandClick',x2+a(2), 800)
    pause(1)
    calllib(libname,'commandClick',200, y2+a(2))
    pause(1)
    calllib(libname,'commandClick',200, 800)
    pause(1)
    sound([1 -1 -1 -1 -1 1 -1 -1 -1 -1 1])
end