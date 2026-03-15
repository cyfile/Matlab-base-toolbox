% 附件 1 一些画图代码
%
% 批量设置属性
% 方法1 set(h_trajectory,{'XDataSource'},cell_temp(:))
% 方法2 [h_lines.Color]=deal(bb{:});
%
%%
clc,clear
% --------- system ---
t_fun = @(t) 0.5*sin(5*t);
NLTV_fun = @(t,x)       [ t_fun(t)*x(1)+x(2)+0.5*sin(t); -x(1)+t_fun(t)*x(2)+0.5*cos(t) ];

%%
N_line = 6;
M_point = 80;
M_differ = round(M_point/N_line);
%
x_0=0;
y_0=0;
%
x_comet=zeros(1,N_line);
y_comet=zeros(1,N_line);
%
X = zeros(M_point,N_line);
Y = zeros(M_point,N_line);
%
cmap = cool(128);
%% --------------------------

figure
set(gcf, 'WindowState', 'maximized')
% set(gca,'color','black')
% set(gca,'colororder',cmap(cmap_ind,:))
hold on
axis equal
% axis tight
axis([-3.5,3.5,-3.5,3.5])

%% --------------------------
h_title = get(gca, 'Title');

plot(x_0,y_0,'bo','linewidth',2.0)

h_comet= plot(x_comet,y_comet,'b.','MarkerSize',25, ...
    'xdatasource','x_comet','ydatasource','y_comet');

h_trajectory = plot(zeros(2,N_line*(M_point-1)), ...
    'visible','off','linewidth',2.0);
h_trajectory = reshape(h_trajectory, M_point-1,N_line);
% a = (1:M_point-1)';
% b = 1:N_line ;
% str_datasource = "(" + string(a) + ":" + string(a+1) + "," + string(b) + ")";
ind_temp = reshape(1:M_point*N_line,M_point,[]);
str_datasource="([" + string(ind_temp(1:end-1,:)) + "," + string(ind_temp(2:end,:)) + "])";
cell_temp=arrayfun(@(a) {"X"+a},str_datasource);
set(h_trajectory,{'XDataSource'},cell_temp(:))
cell_temp=arrayfun(@(a) {"Y"+a},str_datasource);
set(h_trajectory,{'YDataSource'},cell_temp(:))

%%
figure(gcf)
t_delta =0.08;
for k = 1:150
    t_current = (k-1)*t_delta;
    sigma_current = t_fun(t_current);
    %     ind = round(90*(sigma-min_s)/(max_s-min_s))+16;
    ind = round(90*(sigma_current+0.7+0.2)/(2+0.2))+16;
    color_current = cmap(ind,:);


    h_title.String = sprintf('t = %.2fs  \\sigma = %.2f', t_current, sigma_current);

    for kk = 1:N_line
        pointer_line = mod((kk-1)*M_differ+k-1,M_point-1)+1;

        if pointer_line == 1

            set(h_trajectory(:,kk), 'visible','off')
            set(h_trajectory(:,kk), 'Color',color_current )
            %            set(h_trajectory(:,kk), 'Color',[1,0,0,.5])
            t = t_current:t_delta: t_current+t_delta*(M_point-1);
            [t,xt]=ode45(NLTV_fun,t,[x_0;y_0]);
            X(:,kk) = xt(:,1);
            Y(:,kk) = xt(:,2);

            refreshdata(h_trajectory,'caller')

        else
            set(h_trajectory(pointer_line-1,kk), 'visible','on')
            color_temp = [get(h_trajectory(1,kk),'Color'),1-pointer_line/M_point];
            set(h_trajectory(:,kk), 'Color',color_temp )
        end
        x_comet(kk) = X(pointer_line,kk);
        y_comet(kk) = Y(pointer_line,kk);
    end

    refreshdata(h_comet,'caller')
    set(h_comet, 'Color', color_current)

    drawnow limitrate
    pause(0.1)
end