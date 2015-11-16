function [X1,X2,Y1, Y2] = dataSplit( X, y, class1, class2)
N = size(X,1);
X1 = [];
X2 = [];
Y1 =[];
Y2 =[];
for k = 1:N
    if y(k,1) == class1
        X1 = vertcat(X1,X(k,:));
        Y1 = vertcat(Y1,1);
    elseif y(k,1) == class2
        X2 = vertcat(X2,X(k,:));
        Y2 = vertcat(Y2,2);
    end
end
    