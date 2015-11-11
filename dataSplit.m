function [X1,X2] = dataSplit( X,y)
N = size(X,1);
X1 = [];
X2 = [];
for k = 1:N
    if y(k,1) ==1
        X1 = vertcat(X1,X(k,:));
    else 
        X2 = vertcat(X2,X(k,:));
    end
end
    