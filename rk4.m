% author: Thomas Pfurtscheller
% created: 2020/04/08
%
% runge kutta 4
function x2n = rk4(dx, h, x_n, t_n)
% x1n ... x(t+h)
%
% dx ... state space model f(x,u)
% h ... increment 
% x_n ... state x(t)
% t_n ... time

% Butcher table
a1 = 0; a2 = 1/3; a3 = 2/3; a4 = 1;
b21 = 1/3; b31 = -1/3; b32 = 1; b41 = 1; b42 = -1; b43 = 1;
c1 = 1/8; c2 = 3/8; c3 = 3/8; c4 = 1/8;

k1 = dx(t_n + a1*h, x_n);
k2 = dx(t_n + a2*h, x_n + h*b21*k1);
k3 = dx(t_n + a3*h, x_n + h*(b31*k1 + b32*k2));
k4 = dx(t_n + a4*h, x_n + h*(b41*k1 + b42*k2 + b43*k3));

x2n = x_n + h*(c1*k1 + c2*k2 + c3*k3 + c4*k4);
end