function [accuracy,k] = dN(X1,X2,test,testY,zN, algorithm)
%dN Runs deltaNRule between two class data with a pre-determined zN.
% 
accuracy = 0;
test_size = size(test,1);
k = [];

predict = zeros(test_size, 1);  
k_hat = [];
success = 0;
switch algorithm
    case 'DN'
        f = @deltaNRule;
        
    case 'PN'
        f = @pNRule;
end

for i=1:test_size
    %[i]
    %[predict(i),K] = newDeltaNRule(X1, X2, zN, test(i,:),unique(testY));
    %[predict(i),K] = deltaNRule(X1, X2, zN, test(i,:),unique(testY));
    %[predict(i),K] = pNRule(X1,X2,zN,test(i,:),unique(testY));
    [predict(i),K] = f(X1,X2,zN,test(i,:),unique(testY));
    k_hat = vertcat(k_hat,K);
    if testY(i, 1) == predict(i, 1)
        success = success + 1;
    end
end
accuracy = success/test_size;
k=k_hat;

end

