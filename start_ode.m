% author: Thomas Pfurtscheller 
% created: 2020/04/02
%
% start simulation
close all
clear all
format long     % make sure to work with dopple precision 

parameter;
test_funktion(@(t,x) model(t,x,param), [], [], [], 'model')


%% ODE45 SIMULATION
tSim = sim.t_start : sim.h : sim.t_end;
[t,xOde] = ode45(@(t,x) model(t,x,param), tSim, sim.x0, odeset('AbsTol', 1e-7, 'RelTol', 1e-7));

% 3rd state (phi) for plot
y = xOde(:,3);

figure(1)
plot(t,y,'LineWidth',2,'DisplayName','ode45')
grid on; hold on;
xlabel('t [s]')
ylabel('y')
legend('-DynamicLegend');

%% rk3
test_funktion(@(t,x) model(t,x,param),@rk3,[],[],'rk3')

h = 0.05;
x_n = [0, 0, 0, 0]';

% init time vector and result matrix 
t = [];
x1n = [];  
% write init state in first line
x1n(1,:) = x_n;
t(1) = sim.t_start;
k = 1;
while t < sim.t_end
    t(k+1) = sim.t_start + k*h;
    x1n(k+1,:) = rk3(@(t,x) model(t,x,param), h, x1n(k,:)', t(k))';
    k = k + 1;
end
% 3rd state (phi) to update plot
y = x1n(:,3);
 
figure(1)
plot(t,y,'LineWidth',2,'DisplayName','rk3')

%% rk4
test_funktion(@(t,x)model(t,x,param),[],@rk4,[],'rk4')

h = 0.05;
x_n = [0, 0, 0, 0]';

% init time vector and result matrix 
t = [];  
x2n = [];
% write init state in first line
x2n(1,:) = x_n;
t(1) = sim.t_start;
k = 1;
while t < sim.t_end
    t(k+1) = sim.t_start + k*h;
    x2n(k+1,:) = rk4(@(t,x) model(t,x,param), h, x2n(k,:)', t(k))';
    k = k + 1;
end

y = x2n(:,3);

figure(1)
plot(t,y,'LineWidth',2,'DisplayName','rk4')

%% manuelle Schrittweitensteuerung
h = 0.00625; 
d_max = 1e-4;
x1_n = [0, 0, 0, 0];
x2_n = [0, 0, 0, 0]';

% init time vector and result matrix 
t = [];
x1n = [];
x2n = [];
% write init state in first line
x1n(1,:) = x1_n;
x2n(1,:) = x2_n;
t(1) = sim.t_start;

d_n = [];
d_n(1) = 0;
k = 1;
while t < sim.t_end
   t(k+1) = sim.t_start + k*h;
   x1n(k+1,:) = rk3(@(t,x) model(t,x,param), h, x2n(k,:)', t(k))';
   x2n(k+1,:) = rk4(@(t,x) model(t,x,param), h, x2n(k,:)', t(k))';
   
   % local error
   dn_vec = x1n(k+1,:) - x2n(k+1,:);
   d_n(k+1) = norm(dn_vec);
   
   k = k + 1;
end


figure(2)
plot(t, d_n,'LineWidth',2)
grid on; hold on
plot(t, ones(length(t))*d_max, 'LineWidth',2)
xlabel('t [s]')
ylabel('err')
legend('err', 'max err')

%% rk34
h = 0.05;
d_max = 1e-6;
x1_n = [0, 0, 0, 0]';
x2_n = [0, 0, 0, 0]';

% init time vector and result matrix 
t = [];
x1n = [];
x2n = [];
% write init state in first line
x1n(1,:) = x1_n;
x2n(1,:) = x2_n;
t(1) = sim.t_start;
k = 1;
while t < sim.t_end           
   x_1 = rk3(@(t,x) model(t,x,param), h, x2n(k,:)', t(k))';
   x_2 = rk4(@(t,x) model(t,x,param), h, x2n(k,:)', t(k))';
   
   % step control
   h_new = var_step_size(h, x_1, x_2, d_max);
   
   if h_new < h
      k = k - 1;
      h = h_new;
   else
      x2n(k+1,:) = x_2;
      t(k+1) = t(k) + h;
   end
   k = k + 1;
end

y = x2n(:,3);
   
figure(1)
plot(t,y,'LineWidth',2,'DisplayName','rk34')
   

% check rk34
data.t=t;
data.y=y;

test_funktion(@(t,x)model(t,x,param),[],[],data,'rk34')



% %% 
% figure(3)
% plot(data.t, abs(xOde(:,3)-data.y), 'LineWidth', 2)
% grid on, grid minor
% ylabel('error state 3')
% xlabel('time t in s')
% legend('|x_{ode45} - x_{rk34}|')





