function [ pn12,pn21 ] = compute_PN( L,N1,N2 )
%compute_PN requires symbolic math toolbox
K1_1 = ( evalin(symengine,['1/(2^(',int2str(L),'))']) );
K1_2=[];
K2_2=[];
for i=0:N1

    K1_2 = vertcat(K1_2, evalin(symengine,['binomial(',int2str(L),',',int2str(i),')']));
end
for i=0:N2
    K2_2 = vertcat(K2_2, evalin(symengine,['binomial(',int2str(L),',',int2str(i),')']));
end
PN1_2 = K1_1*sum(K1_2);
PN2_1 = K1_1*sum(K2_2);
pn12 = double(PN1_2);
pn21 = double(PN2_1);

end

