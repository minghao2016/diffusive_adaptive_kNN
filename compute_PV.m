function [ pn12 ] = compute_PV( N, u1, u2 )
%compute_PV requires symbolic math toolbox

K1_2=0;
L1 = [];
n = 2*N + 1;
b = 1;
for m=0:N

    K1_2 = evalin(symengine,['binomial(',num2str(n),',',num2str(m),')']);
    %lcap1 = evalin(symengine,['(',num2str(u1),'+',num2str(b))^',num2str(m),' * (',num2str(u2),'+1)^(',num2str(n),'+',num2str(m),')']);
    %lcap2 = evalin(symengine,['(',num2str(u1),'+',num2str(u2),'+2)^(',num2str(N),')']);
    lcap1 = evalin(symengine,['(',num2str(u1 + b),'^',num2str(m),') * (',num2str(u2+b),'^',num2str(n-m),')']);
    lcap2 = evalin(symengine,['(',num2str(u1 + u2 + 2*b),'^',num2str(n),')']);
    L1 = vertcat(L1, K1_2*lcap1/lcap2);
end

PN1_2 = sum(L1);
pn12 = double(PN1_2);
end

