function [ dN_accuracy ] = runDN( X,Y,test,testY,zN )
%runDN Run the deltaN test for a range of zN.
%   

dN_accuracy = [];
K= [];
for k=1:zN
    [dNprediction, delK]= deltaNRuleTest(X,Y,test,testY,k);
    K = vertcat(K,mean(delK));
    dN_accuracy = vertcat(dN_accuracy, checkAccuracy(dNprediction,testY));
end
k =1:zN;
plot(k,dN_accuracy);
end

