% author: Thomas Pfurtscheller 
% created: 2020/04/02
%
% non linear model with ode-system of first order 
function dx = model(t,x,param)

% call inputfunction
u = fn_in(t,x);

c1 = (param.M+param.m)*param.l-param.m*param.l*cos(x(3))^2;

dx = [x(2);
    (-param.m*param.l^2*x(4)^2*sin(x(3)) + u*param.l + param.m*param.l*param.g*cos(x(3))*sin(x(3))) / c1;
    x(4);
    (-param.m*param.l*x(4)^2*sin(x(3))*cos(x(3)) + u*cos(x(3)) + param.g*sin(x(3))*(param.M+param.m)) / c1];
end