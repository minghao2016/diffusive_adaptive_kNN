%clear;
load filtered_data;
mappedTest = mappedX(40001:50000,:);
test_labels = labels(40001:50000,:);
mappedX = mappedX(1:40000,:);
labels = labels(1:40000,:);

k=[];
mean_accuracy =[];
A=[];
for i=0:8
    for j=1:9
        if i<j
            A = vertcat(A, [i j]);
        end
    end
end
k=[];
mean_accuracy =[];
for pn=0.5:0.05:0.9
    classpairs_Accuracy = [];
    for i=1:size(A,1)
        [X1,X2,Y1,Y2] = dataSplit(mappedX,labels,A(i,1),A(i,2));
        X = vertcat(X1,X2);
        Y = vertcat(Y1,Y2);
        [testX1, testX2, testY1,testY2] = dataSplit(mappedTest,test_labels,A(i,1),A(i,2));
        test = vertcat(testX1,testX2);
        testY = vertcat(testY1,testY2);

        [accuracy,K] = runAlgorithm(X1,X2,test,testY,pn,'PN');
        classpairs_Accuracy = horzcat(classpairs_Accuracy, accuracy);
        k = horzcat(k,mean(K));
        A(i,:)  
    end
    mean_accuracy = vertcat(mean_accuracy,mean(classpairs_Accuracy));
end