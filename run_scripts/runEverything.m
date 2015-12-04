load filtered_data;
A=[];
for i=0:8
    for j=1:9
        if i<j
            A = vertcat(A, [i j]);
        end
    end
end
alpha = 1.01:0.05:1.5;
[dn,k_dn] = runForAllClassPairs(A,mappedX,labels,mappedTest,test_labels,alpha,'DN');
alpha = 1.01:0.01:1.2;
[dv,k_dv] = runForAllClassPairs(A,mappedX,labels,mappedTest,test_labels,alpha,'DV');
[cdv,k_cdv] = runForAllClassPairs(A,mappedX,labels,mappedTest,test_labels,alpha,'CDV');

k_pn=[];
pn =[];
for zpn=0.5:0.03:0.75
    classpairs_Accuracy = [];
    for i=1:size(A,1)
        [X1,X2,Y1,Y2] = dataSplit(mappedX,labels,A(i,1),A(i,2));
        X = vertcat(X1,X2);
        Y = vertcat(Y1,Y2);
        [testX1, testX2, testY1,testY2] = dataSplit(mappedTest,test_labels,A(i,1),A(i,2));
        test = vertcat(testX1,testX2);
        testY = vertcat(testY1,testY2);
        
        
        [accuracy,K] = runAlgorithm(X1,X2,test,testY,zpn,'PN');
        classpairs_Accuracy = horzcat(classpairs_Accuracy, accuracy);
        k_pn = horzcat(k_pn,mean(K));
        
    end
    pn = vertcat(pn,mean(classpairs_Accuracy));
end