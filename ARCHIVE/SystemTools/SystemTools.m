classdef SystemTools
    %   SystemTools Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods(Static = true)
%         Java Metods are undoced secret. Discrepancy: call
%         <ClassObj>.Java; followed by JKeyx = ans;
        function [JKey] = Java()
            import java.awt.Robot; import java.awt.event.*; JKey = Robot;
        end
        
        function NETFramework()
            if(~NET.isNETSupported), errordlg(['Supported Version of Micro'...
            'soft® .NET Framework Not Found.'],'Critical Error'); return; end
            
            NET.addAssembly('System.Windows.Forms');
            import System.Windows.Forms.*;
            import System.Diagnostics.*;
            import System.Drawing.*;
        end
        
        function Result = TopmostMsg(Message, Title, Button)

            topmostForm = System.Windows.Forms.Form();
            topmostForm.Size = System.Drawing.Size(1, 1);
            topmostForm.StartPosition = System.Windows.Forms.FormStartPosition.Manual;
            rect = System.Windows.Forms.SystemInformation.VirtualScreen;
            topmostForm.Location = System.Drawing.Point(rect.Bottom + 10, rect.Right + 10);
            topmostForm.Show();

            %   Make this form the active form and make it TopMost
            topmostForm.Focus();
            topmostForm.BringToFront();
            topmostForm.TopMost = true;

            %   Finally show the MessageBox with the form just created as its owner
            Result = System.Windows.Forms.MessageBox.Show(topmostForm, Message, Title, Button);
            topmostForm.Dispose();
        end
        
        function waitforuser(Msg)

            if ~nargin, Msg = 'Click here to Continue>>'; end

            WaitWindow = System.Windows.Forms.Form();
            Response = System.Windows.Forms.Button();
            fwidth = 160; fheight = 40;

            screensize = get(0, 'ScreenSize');
            swidth = screensize(3);
            sheight = screensize(4);
            fwidth = min(fwidth, swidth);
            fheight = min(fheight, sheight);
            rwidth  = swidth-fwidth;
            rheight = sheight-fheight;

            Response.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            Response.FlatAppearance.BorderSize = 0;
            Response.Width = 140; Response.Height = 20;
            Response.Text = Msg;
            Response.Location = System.Drawing.Point(10, 10);
            Response.BackColor = System.Drawing.Color.Transparent;
            Response.ForeColor = System.Drawing.Color.Red;

            WaitWindow.TopMost = true;
            WaitWindow.Text = 'Manual Selection';
            WaitWindow.BackColor = System.Drawing.Color.Yellow;
            WaitWindow.Width = fwidth; WaitWindow.Height = fheight;
            WaitWindow.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            WaitWindow.CancelButton = Response;
            WaitWindow.StartPosition = System.Windows.Forms.FormStartPosition.Manual;
            WaitWindow.DesktopLocation = System.Drawing.Point(rwidth, rheight/2);
            WaitWindow.Controls.Add(Response);
            WaitWindow.ShowInTaskbar = false;

            Res = WaitWindow.ShowDialog(); %waitfor(Res)
        end
        
        function NotificationIcon = Notify(BToolTipMsg, BToolTipTitle, AppToolTip, Icon)
            %           How to Use Notify
            % Notify('Balloon Tool Tip', 'Balloon Title', 'Notification App', [pwd '\icon.ico']);

            Container = System.ComponentModel.Container;
            NotificationIcon = System.Windows.Forms.NotifyIcon(Container);

            %           Using Standard SystemIcons
            % SystemIcons: Application, Asterisk, Error, Exclamation, Hand,
            %              Information, Question, Shield, Warning, WinLogo
            % NotifyIcon1.Icon = SystemIcons.Error;

            NotificationIcon.Icon = System.Drawing.Icon(Icon);

            NotificationIcon.Visible = true;
            NotificationIcon.Text = AppToolTip;

            % ToolTipIcon Members: Error, Info, None, Warning
            NotificationIcon.ShowBalloonTip(30000,BToolTipTitle,BToolTipMsg, System.Windows.Forms.ToolTipIcon.Info);

            % pause(9.75);
            % NotificationIcon.Visible = false;
            % NotificationIcon.Dispose();

        end

        function help()
            Notifyhelp.Syntx = ['<ClassObj>.Notify(''Balloon Tool Tip'', ' ...
                                '''Balloon Title'', ''Notification App'', ' ...
                                '[pwd ''\icon.ico'']);'];
            Notifyhelp.Tips = ['Make sure the icon.ico file is present in ' ...
                           'current folder to use this syntax.' char(13) char(9) ...
                           'To remove tray icon use <NotificationIconObj>.' ...
                           'Visible = false; followed by <NotificationIconObj>.Dispose();.'];
                           
            TopMsg.Syntx = ['<ClassObj>.TopmostMsg(''Message goes here...''' ...
                            ', ''title'', System.Windows.Forms.MessageBoxBu' ...
                            'ttons.YesNo)'];
            TopMsg.Tips = 'View General Help.';
            
            waitusr.Syntx = ['<ClassObj>.waitforuser or <ClassObj>.waitfor' ...
                             'user(''Short Message'')'];
            waitusr.Tips = 'View General Help.';
            
            AppSelt.Syntx = ['Stats = <ClassObj>.AppSelect(''Process Name'',' ...
                             ' ''Window State'')'];
            AppSelt.Tips = 'Run the demo code below to see it in action.';
            
            StaTProc.Syntx = 'Stats = <ClassObj>.StartProcess()';
            StaTProc.Tips = 'View General Help.';
            
            generalhelp = ['Every function in this class requires .NET sup' ...
                           'port.' char(13) 'So make sure to call <Class ' ...
                           'Obj>.NETFramework() at least once before any ' ...
                           'function calls.']; clc;
            disp(['waitforuser Function:' char(10) char(13) char(9) 'Syntax: ' ...
                   waitusr.Syntx char(10) char(13) char(9) waitusr.Tips char(13)]);
            disp(['TopmostMsg Function:' char(10) char(13) char(9) 'Syntax: ' ...
                   TopMsg.Syntx char(10) char(13) char(9) TopMsg.Tips char(13)]);
            disp(['Notify Function:' char(10) char(13) char(9) 'Syntax: ' ...
                   Notifyhelp.Syntx char(10) char(13) char(9) Notifyhelp.Tips]);
            disp([char(13) 'StartProcess Function:' char(10) char(13) char(9) 'Syntax: ' ...
                   StaTProc.Syntx char(10) char(13) char(9) StaTProc.Tips]);
            disp([char(13) 'AppSelect Function:' char(10) char(13) char(9) 'Syntax: ' ...
                   AppSelt.Syntx char(10) char(13) char(9) AppSelt.Tips char(13)]);
            disp([char(9) char(9) '...Demo Code...' char(10) char(13) 'Sys' ...
                  'Obj = SystemTools;' char(13) 'SysObj.NETFramework();' char(13) ...
                  'ProcCred = SysObj.StartProcess;' char(13) 'if ~ProcCred.HasExited' ...
                  char(13) char(9) 'AppSelStats = ' 'SysObj.AppSelect(char(ProcCred.' ...
                  'MainWindowTitle), ''showmaximized'');' char(13) char(9) 'if AppSel' ...
                  'Stats>0, disp(''Operation Successfull'');' char(13) char(9) 'else di' ...
                  'sp(''Operation Failed''); end' char(13) 'else msgbox(''The Process' ...
                  ' has exited'');' char(13) 'end' char(13) char(9) char(9) '<<<<<<<<<' ...
                  '>>>>>>>>>'])
            disp([char(13) 'General Help:' char(13) generalhelp]);
        end
        
        function SWStats = AppSelect(WName, WState)
%             *******************************************************************************            
%             Dynamic Variable Assignment Workaround for Matlab...
%             *******************************************************************************

            global fcns structs enums; structs = []; enums = []; fcns.alias = {''};
%             *******************************************************************************            
%             Look-Up Table for Window State Mapping...
%             *******************************************************************************

            %     Look-Up Initialization...
            LokUpX = {'hide'; 'shownormal'; 'normal'; 'showminimized'; 'showmaximized'; ...
            'maximize'; 'shownoactivate'; 'show'; 'minimize'; 'showminnoactive'; ...
            'showna'; 'restore'; 'showdefault'; 'forceminimize'; 'max'};
            LokUp = [0, 1, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11];  
            %     Failsafe retrival enacted.
            Optn = find(strcmp(LokUpX, WState));
            if ~isempty(Optn), LokUpX = LokUp(Optn);
            else errordlg('Code Error: Unknown Window State', '!!Code Error!!'); end
%             *******************************************************************************            
%             Initiating Function Call Parameter Mapping...
%             *******************************************************************************

            %  HWND _stdcall FindWindowA(LPCSTR,LPCSTR); 
            fcns.name{1} = 'FindWindowA';
            fcns.calltype{1} = 'cdecl';
            fcns.LHS{1} = 'voidPtr';
            fcns.RHS{1} = {'int8Ptr', 'string'};

            %  BOOL _stdcall ShowWindow(HWND,int); 
            fcns.name{2} = 'ShowWindow';
            fcns.calltype{2} = 'cdecl';
            fcns.LHS{2} = 'int32';
            fcns.RHS{2} = {'voidPtr', 'int32'};

            %  BOOL _stdcall SetForegroundWindow(HWND); 
            fcns.name{3} = 'SetForegroundWindow';
            fcns.calltype{3} = 'cdecl';
            fcns.LHS{3} = 'voidPtr';
            fcns.RHS{3} = {'voidPtr'};
%             *******************************************************************************            
%             Saving Variables for loadlibrary Workaround in Matlab...
%             *******************************************************************************

            save('LoadLib.mat', 'enums', 'fcns', 'structs');
%             *******************************************************************************            
%             Load System Library Procedure Starts Here...
%             *******************************************************************************

            %   FailSafe Load Library Enacted...
            if ~libisloaded('WinUser32Lib'), loadlibrary('user32.dll','LoadLib.mat','alias','WinUser32Lib');
            end
            %   Find Process Window Handle...
            WHand = calllib('WinUser32Lib', 'FindWindowA', [], char(WName));
            %   Make Process Window Active...
            calllib('WinUser32Lib', 'SetForegroundWindow', WHand);
            %   Change Process Window State...
            SWStats = calllib('WinUser32Lib', 'ShowWindow', WHand, LokUpX);
            %   Failsafe Unload Library Enacted...
            if libisloaded('WinUser32Lib'), unloadlibrary 'WinUser32Lib'; end
            %   Failsafe Delete Enacted...
            if exist('LoadLib.mat', 'file')==2, try delete('LoadLib.mat'); end  %#ok<TRYNC>
            end
        end
        
        function [MyProcess] = StartProcess
            
            [file, folder] = uigetfile({'*.exe'}, 'Select an Application.', pwd);
            if file, file = [folder file]; else return; end
            [~, ProcName,~] = fileparts(file);

            MyProcess = System.Diagnostics.Process();
            MyProcess.StartInfo.FileName = file;
            MyProcess.Start(); CID = MyProcess.Id; pause(1);
            MyProcess = System.Diagnostics.Process.GetProcessesByName(ProcName);

            if (MyProcess.Length > 0)
            for i = 1: MyProcess.Length
                if (MyProcess(i).Id == CID), MyProcess = MyProcess(i); break; end
            end
            end 
        end
                
    end
    
end

