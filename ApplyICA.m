% A seguinte função implementa o ICA linear
%
% Entrada:  x é mistura uma matriz(dxn)
%
%           y é os sinais estimados
%           v é a matriz ortogonal de branqueamento
%
%
%
function [y,w, v] = ApplyICA(x)

    n = size(x,1);

    [E, D] = eig(cov(x'));
    v = E*D^(-0.5)*E' * x;
    z = repmat(sqrt(sum(v.^2)),n,1).*v;
    [EE, DD] = eig(cov(z'));
    y = EE'*v;
    w = EE';
end