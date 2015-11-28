function [accuracy,k] = runAlgorithm(X1,X2,test,testY,zN, algorithm)
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
    case 'newDN'
        f = @newDeltaNRule
    case 'DV'
        f = @deltaVRule
end

for i=1:test_size
    [predict(i),K] = f(X1,X2,zN,test(i,:),unique(testY));
    %k_hat = vertcat(k_hat,K);
    if testY(i, 1) == predict(i, 1)
        success = success + 1;
    end
end
accuracy = success*100/test_size;
%k=k_hat;

end

