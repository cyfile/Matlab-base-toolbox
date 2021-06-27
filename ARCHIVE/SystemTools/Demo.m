
ClsObj = SystemTools();
ClsObj.NETFramework();

MyProcess = System.Diagnostics.Process();
            MyProcess.StartInfo.FileName = 'C:/Windows/Notepad.exe';
            MyProcess.Start(); %CID = MyProcess.Id; pause(1);
%             MyProcess = System.Diagnostics.Process.GetProcessesByName('Notepad');
% 
% if (MyProcess.Length > 0)
%     for i = 1: MyProcess.Length
%         if (MyProcess(i).Id == CID), MyProcess = MyProcess(i); break; end
%     end
% end

%                       Windows Options Available
% 'hide'; 'shownormal'; 'normal'; 'showminimized'; 'showmaximized'; ...
% 'maximize'; 'shownoactivate'; 'show'; 'minimize'; 'showminnoactive'; ...
% 'showna'; 'restore'; 'showdefault'; 'forceminimize'; 'max'

try
        
    if ~MyProcess.HasExited

        ClsObj.TopmostMsg('Lets try to Maximize it?', 'Maximize', System.Windows.Forms.MessageBoxButtons.OK);
        AppSelStats = ClsObj.AppSelect(char(MyProcess.MainWindowTitle), 'showmaximized');
        if AppSelStats>0, disp('Operation Successfull');
        else, disp('Operation Failed'); end

        ClsObj.TopmostMsg('How about Hiding?', 'Hide', System.Windows.Forms.MessageBoxButtons.OK);
        AppSelStats = ClsObj.AppSelect(char(MyProcess.MainWindowTitle), 'hide');
        if AppSelStats>0, disp('Operation Successfull');
        else, disp('Operation Failed'); end

        ClsObj.TopmostMsg('How about unhide?', 'Show', System.Windows.Forms.MessageBoxButtons.OK);
        AppSelStats = ClsObj.AppSelect(char(MyProcess.MainWindowTitle), 'show');
        if AppSelStats<1, disp('Operation Successfull');
        else, disp('Operation Failed'); end

        ClsObj.TopmostMsg('How about Minimize?', 'Minimize', System.Windows.Forms.MessageBoxButtons.OK);
        AppSelStats = ClsObj.AppSelect(char(MyProcess.MainWindowTitle), 'minimize');
        if AppSelStats>0, disp('Operation Successfull');
        else, disp('Operation Failed'); end

        ClsObj.TopmostMsg('How about ShowNormal?', 'ShowNormal', System.Windows.Forms.MessageBoxButtons.OK);
        AppSelStats = ClsObj.AppSelect(char(MyProcess.MainWindowTitle), 'shownormal');
        if AppSelStats>0, disp('Operation Successfull');
        else, disp('Operation Failed'); end

    else, ClsObj.TopmostMsg('Process is not running', 'Error', System.Windows.Forms.MessageBoxButtons.OK);
    end

catch Ex
    ClsObj.TopmostMsg(['Got an error in file: ' Ex.stack.name '.m @ line:' num2str(Ex.stack.line) ':' newline ...
        Ex.message ],['Error: ' Ex.identifier], System.Windows.Forms.MessageBoxButtons.OK);
end