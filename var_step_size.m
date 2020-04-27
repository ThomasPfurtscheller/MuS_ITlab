% author: Thomas Pfurtscheller
% created: 2020/04/09
%
% adaptive step size control
function h_n = var_step_size(h_old, x1n, x2n, d_max)
% h_n ... new step size at time t 
% h_old ... old step size at time t-1
% x1n ... state vector with rk3
% x2n ... state vector with rk4
% d_max ... maximum error 

% constants
gamma1 = 2; 
gamma2 = 0.5; 
beta = 0.7;

dn_vec = x1n - x2n;
d_n = norm(dn_vec);

kappaOpt = (d_max/d_n)^(1/4);

    if d_n < d_max 
        h_n = h_old * min(gamma1, beta*kappaOpt);
    else
        h_n = h_old * max(gamma2, beta*kappaOpt);    
    end
end