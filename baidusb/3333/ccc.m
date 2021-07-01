% Display a hyperlink in the Command Window
disp('<a href="matlab:echodemo find">Run in the Command Window</a>')

%%

str=['MATLAB automatically executes the file ',...
    '<a href="matlab:edit matlabrc">matlabrc.m</a> at startup time.'];
disp(str)

%%

str=['Run MATLAB function ',...
    '<a href="matlab:ones(2)">ones(2)</a>',...
    ' in the Command Window.'];
disp(str)