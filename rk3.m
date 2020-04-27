% author: Thomas Pfurtscheller
% created: 2020/04/08
%
% runge kutta 3
function x1n = rk3(dx, h, x_n, t_n)
% x1n ... x(t+h)
%
% dx ... state space model f(x,u)
% h ... increment 
% x_n ... state x(t)
% t_n ... time

% Butcher table
a1 = 0; a2 = 1/3; a3 = 2/3;
b21 = 1/3; b31 = 0; b32 = 2/3; 
c1 = 1/4; c2 = 0; c3 = 3/4;

k1 = dx(t_n + a1*h, x_n);
k2 = dx(t_n + a2*h, x_n + h*b21*k1);
k3 = dx(t_n + a3*h, x_n + h*b31*k1 + h*b32*k2);

x1n = x_n + h*(c1*k1 + c2*k2 + c3*k3);
end