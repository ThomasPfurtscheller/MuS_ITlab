% author: Thomas Pfurtscheller 
% created: 2020/04/02
%
% linear model 
function dx = linearModel(t,x,param)

% call inputfunction
u = fn_in(t,x);

% A = [[0, 1, 0, 0];
%     [0, 0, param.m*param.g, 0];
%     [0, 0, 0, 1];
%     [0, 0, (param.M+param.m)*param.g / (param.M*param.l), 0]];
% 
% b = [0;
%     1/param.M;
%     0;
%     -1/(param.M*param.l)];

% % c1 = (param.M+param.m)*param.l-param.m*param.l;
% % 
% % A = [[0, 1, 0, 0];
% %     [0, 0, param.m*param.l*param.g / c1, 0];
% %     [0, 0, 0, 1];
% %     [0, 0, (param.M+param.m)*param.g / c1, 0]];
% % 
% % b = [0;
% %     param.l / c1;
% %     0;
% %     1 /  c1];
% % 
% % dx = A*x + b*u;

% um die Instabile Ruhelage
% % Q = [[1, 0, 0, 0];
% %     [0, param.M+param.m, 0, -param.m*param.l];
% %     [0, 0, 1, 0];
% %     [0, -1, 0, param.l]];
% % 
% % R = [[0, 1, 0, 0];
% %     [0, 0, 0, 0];
% %     [0, 0, 0, 1];
% %     [0, 0, param.g, 0]];
% % 
% % s = [0; u; 0; 0];

Q = [[1, 0, 0, 0];
    [0, param.M+param.m, 0, param.m*param.l];
    [0, 0, 1, 0];
    [0, 1, 0, param.l]];

R = [[0, 1, 0, 0];
    [0, 0, 0, 0];
    [0, 0, 0, 1];
    [0, 0, -param.g, 0]];

s = [0; u; 0; 0];

dx = inv(Q) * (R*x + s);
end