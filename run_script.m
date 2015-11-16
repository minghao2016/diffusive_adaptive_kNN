load_cifar
[mappedX,~] = compute_mapping(horzcat(labels,data), 'FDA', 9);
[mappedTest,~] = compute_mapping(horzcat(test_labels,test_data),'FDA',9);
[X1,X2,Y1,Y2] = dataSplit(mappedX,labels,1,2);
X = vertcat(X1,X2);
Y = vertcat(Y1,Y2);
[testX1, testX2, testY1,testY2] = dataSplit(mappedTest,test_labels,1,2);
test = vertcat(testX1,testX2);
testY = vertcat(testY1,testY2);
prediction = knnclassify(test,X,Y);
accuracy = [];
for k=1:100
    dNprediction = deltaNRuleTest(mappedX,labels,test,testY,k);
    accuracy = vertcat(accuracy, checkAccuracy(dNprediction,testY));
end
k =1:100;
accuracy = accuracy(2:101,1);
plot(k,accuracy);
xlabel('zN');
ylabel('accuracy');