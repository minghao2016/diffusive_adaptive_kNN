function [ mean_accuracy,k ] = runForAllClassPairs( A,mappedX,labels,mappedTest,test_labels,alpha_range,algorithm )

lambdas = [];
for i=0:9
    [X,~,~,~] = dataSplit(mappedX,labels,i,i);
    lambda1 = estimateRateParameter(X,mean(X));
    lambdas = vertcat(lambdas,lambda1);
end
%alpha = 1.0852;
k=[];
mean_accuracy =[];
for alpha=alpha_range
    display(['alpha=',num2str(alpha)]);
    zNs = [];
    classpairs_Accuracy = [];
    for i=1:size(A,1)
        [X1,X2,Y1,Y2] = dataSplit(mappedX,labels,A(i,1),A(i,2));
        X = vertcat(X1,X2);
        Y = vertcat(Y1,Y2);
        [testX1, testX2, testY1,testY2] = dataSplit(mappedTest,test_labels,A(i,1),A(i,2));
        test = vertcat(testX1,testX2);
        testY = vertcat(testY1,testY2);
        lambda1 = lambdas(A(i,1)+1);
        lambda2 = lambdas(A(i,2)+1);

        zN = compute_z(lambda1,lambda2,alpha,algorithm);
        zNs = vertcat(zNs,zN);
        [accuracy,K] = runAlgorithm(X1,X2,test,testY,zN,algorithm);
        classpairs_Accuracy = horzcat(classpairs_Accuracy, accuracy);
        k = horzcat(k,mean(K));
        
        
    end
    mean_accuracy = vertcat(mean_accuracy,mean(classpairs_Accuracy));
end

end

