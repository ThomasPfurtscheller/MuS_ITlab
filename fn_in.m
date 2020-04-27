% author: Thomas Pfurtscheller
% created: 2020/04/02
%
% function for inputsignal 
function u = fn_in(t,x)
% returns the inputsignal at time t 
% t ... time (scalar)
% x ... statevector (don´t know we it's needed ??)

u = 0.2 * sin((2*pi/3)*t);
end