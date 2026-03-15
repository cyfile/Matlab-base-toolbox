% 1.8 时变系统和非线性系统的状态空间表达式
%
%
clear,clc
%%
% A = [σ,ω;-ω,σ];
%
%     σ == sin(5*t)-0.3
%     ω == 1
%     dx1 =  σ*x1 + ω*x2
%     dx2 = -ω*x1 + σ*x2
%
%     s = sin(5*t)-0.3  % sigma
%     w = 1           % omega
%     dx1 = s*x1 + w*x2
%     dx2 = -w*x1 + s*x2

% --------- system ---
t_fun = @(t) sin(5*t)-0.3;
% NLTV_fun 希望能被设计成一个在(0,0)点附近的非线性时变系统
% dx1dx2   希望能被设计成一个上述系统在各个时间点的(0,0)点附近的线性化系统.
NLTV_fun = @(t,x)       [ t_fun(t)*x(1)+x(2); -x(1)+t_fun(t)*x(2) ];
dx1dx2 = @(t,x1,x2) deal( t_fun(t)*x1 + x2  , -x1 + t_fun(t)*x2   );

% --------- quiver data ---
[x1,x2] = meshgrid(-2.5:0.5:2.5);
[dx1,dx2] = dx1dx2(0,x1,x2);

% --------- comet data ---
r0 = 0;
r1 = 1;
r2 = 2*r1*cos(pi/6);
r3 = max(roots([1 -2*r2*cos(2*pi/24/2) r2*r2-1]));
zeta1 = pi/6:pi/3:1.9*pi;
zeta2 = 0:pi/6:1.99*pi;
zeta3 = pi/24:pi/12:1.99*pi;
x_comet=[0,r1*cos(zeta1),r2*cos(zeta2),r3*cos(zeta3)];
y_comet=[0,r1*sin(zeta1),r2*sin(zeta2),r3*sin(zeta3)];

% -------- Interval of integration (time span) ---
t = linspace(0,5,300);
sigma = t_fun(t);
[min_s,max_s] = bounds(sigma);
cmap = jet(128);
% cmap = hsv(128);
% cmap = cool(128);
cmap_ind = round(90*(sigma-min_s)/(max_s-min_s))+16;

n = length(x_comet);
nt = length(t);


% -------- 实际的状态轨迹 ---
X = zeros(nt,n);
Y = zeros(nt,n);
for k = 1:n
    [t,xt]=ode45(NLTV_fun,t,[x_comet(k);y_comet(k)]);
    X(:,k) = xt(:,1);
    Y(:,k) = xt(:,2);
end

%%
figure(gcf)
set(gcf, 'WindowState', 'maximized')
delete(gca)
set(gca,'color','black')
% set(gca,'colororder',cmap(cmap_ind,:))
hold on
axis equal
% axis tight
% axis([-3,3,-3,3])


plot(x_comet,y_comet,'wo','linewidth',2.0)
h_trajectory = plot(X,Y,'linewidth',1.0);
k = n - randi(20);
scatter(X(:,k), Y(:,k), 15, cmap(cmap_ind,:), 'filled');
k = n - randi(20);
h_lines = plot([X(1:end-1,k),X(2:end,k)]',[Y(1:end-1,k),Y(2:end,k)]', ...
    'linewidth',3.0);
line_color = cmap(cmap_ind(1:end-1),:);
bb=mat2cell(line_color,ones(nt-1,1));
[h_lines.Color]=deal(bb{:});

h_quiver = quiver(x1,x2,dx1,dx2, ...
    'marker','+','linewidth',1.5, 'ShowArrowHead' , 'off',...
    'udatasource','dx1','vdatasource','dx2');
h_comet= plot(x_comet,y_comet,'b.','MarkerSize',25, ...
    'xdatasource','x_comet','ydatasource','y_comet');

for k = 1:nt
    t_current = t(k);
    sigma_current = sigma(k);
    color_current = cmap(cmap_ind(k),:);

    title(sprintf('t = %.2fs  \\sigma = %.2f', t_current , sigma_current) );

    x_comet = X(k,:);
    y_comet = Y(k,:);
    refreshdata(h_comet,'caller')
    set(h_comet, 'Color', color_current)

    [dx1,dx2] = dx1dx2(t_current,x1,x2);
    refreshdata(h_quiver,'caller')
    set(h_quiver, 'Color', color_current)

    drawnow limitrate
    pause(0.1)
end


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

return
clc,clear
% --------- system ---
t_fun = @(t) sin(5*t)-0.3;
% NLTV_fun 希望能被设计成一个在(0,0)点附近的非线性时变系统
% dx1dx2   希望能被设计成一个上述系统在各个时间点的(0,0)点附近的线性化系统.
NLTV_fun = @(t,x)       [ t_fun(t)*x(1)+x(2); -x(1)+t_fun(t)*x(2) ];
dx1dx2 = @(t,x1,x2) deal( t_fun(t)*x1 + x2  , -x1 + t_fun(t)*x2   );

% --------- quiver data ---
[x1,x2] = meshgrid(-2.5:0.5:2.5);
[dx1,dx2] = dx1dx2(0,x1,x2);

%%
N_line = 7;
M_point = 100;
M_differ = round(M_point/N_line);
%
r_0 = 0.9;
x_0=1.5+r_0*rand;
y_0=1.5+r_0*rand;
%
x_comet=ones(1,N_line)*x_0;
y_comet=ones(1,N_line)*y_0;
%
trajectory_data = repmat([x_0,y_0],M_point, 1, N_line);
%
cmap = turbo(128);
% cmap = cool(128);

% --------------------------

figure
set(gcf, 'WindowState', 'maximized')
% set(gca,'color','black')
% set(gca,'colororder',cmap(cmap_ind,:))
hold on
axis equal
% axis tight
axis([-3.5,3.5,-3.5,3.5])

h_title = get(gca, 'Title');

plot(x_0,y_0,'bo','linewidth',2.0)

h_quiver = quiver(x1,x2,dx1,dx2, ...
    'marker','+','linewidth',1.5, 'ShowArrowHead' , 'off',...
    'udatasource','dx1','vdatasource','dx2');

h_comet= plot(x_comet,y_comet,'b.','MarkerSize',25, ...
    'xdatasource','x_comet','ydatasource','y_comet');

h_trajectory = cell(1,N_line);
for k=1:N_line
    h_trajectory{k} = line(nan(2,M_point-1),nan(2,M_point-1), ...
        'visible','off','linewidth',2.0);
end

%%
figure(gcf)
t_delta =0.08;
for k = 1:150
    t_current = (k-1)*t_delta;
    sigma_current = t_fun(t_current);
    % ind = round(90*(sigma-min_s)/(max_s-min_s))+16;
    temp_ind = round(100*(sigma_current+1.3+0.2)/(2+0.2))+12;
    temp_ind = min(max(temp_ind,1), size(cmap,1)); % Clamped index
    color_current = cmap(temp_ind,:);

    h_title.String = sprintf('t = %.2fs  σ = %.2f', t_current, sigma_current);
%     title(sprintf('t = %.2fs  \\sigma = %.2f', t_current , sigma_current) );

    for kk = 1:N_line
        pointer_line = mod((kk-1)*M_differ+k-1,M_point-1)+1;

        if pointer_line == 1

            temp_t = t_current:t_delta: t_current+t_delta*(M_point-1);
            [~,xt]=ode45(NLTV_fun,temp_t,[x_0;y_0]);

            trajectory_data(:,:,kk) = xt;

            delete(h_trajectory{kk})
            h_trajectory{kk} = line( ...
                [xt(1:end-1,1),xt(2:end,1)]',[xt(1:end-1,2),xt(2:end,2)]', ...
                'color',color_current, ...
                'linewidth',2.0,'visible','off');

            x_comet(kk) = x_0;
            y_comet(kk) = y_0;
        else
            set(h_trajectory{kk}(pointer_line-1), 'visible','on')
            alpha_val = 1 - (pointer_line-1)/M_point;
            temp_color = get(h_trajectory{kk}(1),'Color');
            set(h_trajectory{kk}, 'Color',[temp_color,alpha_val] )

            x_comet(kk) = trajectory_data(pointer_line,1,kk);
            y_comet(kk) = trajectory_data(pointer_line,2,kk);
        end

    end

    refreshdata(h_comet,'caller')
    set(h_comet, 'Color', color_current)

    [dx1,dx2] = dx1dx2(t_current,x1,x2);
    refreshdata(h_quiver,'caller')
    set(h_quiver, 'Color', color_current)

    drawnow limitrate
    pause(0.1)
end
