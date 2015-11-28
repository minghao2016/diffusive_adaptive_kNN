%filtered_load
clear;
load filtered_data;
mappedTest = mappedX(40001:50000,:);
test_labels = labels(40001:50000,:);
mappedX = mappedX(1:40000,:);
labels = labels(1:40000,:);

%code from here runs delta N rule.
k=[];
dnAccuracy = [];
A=[];
for i=0:8
    for j=1:9
        if i<j
            A = vertcat(A, [i j]);
        end
    end
end
lambdas = [];
for i=0:9
    [X,~,~,~] = dataSplit(mappedX,labels,i,i);
    lambda1 = estimateRateParameter(X,mean(X));
    lambdas = vertcat(lambdas,lambda1);
end
%alpha = 1.0852;
alpha = 1.2;
zNs = [];
for i=1:size(A,1)
    [X1,X2,Y1,Y2] = dataSplit(mappedX,labels,A(i,1),A(i,2));
    X = vertcat(X1,X2);
    Y = vertcat(Y1,Y2);
    [testX1, testX2, testY1,testY2] = dataSplit(mappedTest,test_labels,A(i,1),A(i,2));
    test = vertcat(testX1,testX2);
    testY = vertcat(testY1,testY2);
    lambda1 = lambdas(A(i,1)+1);
    lambda2 = lambdas(A(i,2)+1);
    
    
    
    if lambda1>lambda2
        zN = log(alpha)/log(lambda1/lambda2);
    else
        zN = log(alpha)/log(lambda2/lambda1);
    end
    zNs = vertcat(zNs,zN);
    [accuracy,K] = runAlgorithm(X1,X2,test,testY,zN,'DN');
    dnAccuracy = horzcat(dnAccuracy, accuracy);
    k = horzcat(k,mean(K));
    A(i,:)
end