%load cifar-10 dataset
load_cifar;

%run FDA on data,test_data
[mappedX,~] = FDA(double(data'),labels,9);
[mappedTest,~] = FDA(double(test_data'),test_labels,9);
mappedX = mappedX';
mappedTest = mappedTest';

%run filter to get class1, class2 data
[X1,X2,Y1,Y2] = dataSplit(mappedX,labels,1,2);
X = vertcat(X1,X2);
Y = vertcat(Y1,Y2);
[testX1, testX2, testY1,testY2] = dataSplit(mappedTest,test_labels,1,2);
test = vertcat(testX1,testX2);
testY = vertcat(testY1,testY2);
clear X1 X2 Y1 Y2 testX1 textX2 testY1 testY2;
clear mappedX mappedTest

runDN(X,Y,test,testY,200);








