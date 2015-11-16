function [X1,X2,Y] = dataSplit( X,y, class1, class2)
N = size(X,1);
X1 = [];
X2 = [];
Y =[];
for k = 1:N
    if y(k,1) == class1
        X1 = vertcat(X1,X(k,:));
        Y = vertcat(Y,1);
    elseif y(k,1) == class2
        X2 = vertcat(X2,X(k,:));
        Y = vertcat(Y,2);
    end
end
    