clear;
load filtered_data;
%mappedTest = mappedX(40001:50000,:);
%test_labels = labels(40001:50000,:);
%mappedX = mappedX(1:40000,:);
%labels = labels(1:40000,:);

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
for pn=0.6:0.01:0.7
    classpairs_Accuracy = [];
    for i=1:size(A,1)
        %[X1,X2,Y1,Y2] = dataSplit(mappedX,labels,A(i,1),A(i,2));
        %X = vertcat(X1,X2);
        %Y = vertcat(Y1,Y2);
        %[testX1, testX2, testY1,testY2] = dataSplit(mappedTest,test_labels,A(i,1),A(i,2));
        %test = vertcat(testX1,testX2);
        %testY = vertcat(testY1,testY2);
        
        [x1, x2, y1, y2] = dataSplit(mappedX, labels, A(i,1), A(i,2));
        temp_size = size(x1, 1);
        test_x1 = x1( 4 * temp_size /5 + 1 : temp_size, :); 
        x1 = x1(1:4 * temp_size /5, :);
        temp_size = size(x2, 1);
        test_x2 = x2( 4 * temp_size/5 + 1 : temp_size, :);
        x2 = x2(1 : 4 * temp_size /5, :);
        temp_size = size(y1, 1);
        test_y1 = y1(4 * temp_size/5 + 1 : temp_size, :);
        y1 = y1(1:4 * temp_size /5, :);
        temp_size = size(y2, 1);
        test_y2 = y2( 4 * temp_size/5 + 1 : temp_size, :);
        y2 = y2(1:4 * temp_size /5, :);

        test = vertcat(test_x1, test_x2);
        test_labels = vertcat(test_y1, test_y2);
        test_size = size(test_labels, 1);
        
        [accuracy,K] = runAlgorithm(x1,x2,test,test_labels,pn,'PN');
        classpairs_Accuracy = horzcat(classpairs_Accuracy, accuracy);
        k = horzcat(k,mean(K));
        
    end
    mean_accuracy = vertcat(mean_accuracy,mean(classpairs_Accuracy));
    pn
    mean(classpairs_Accuracy)
end