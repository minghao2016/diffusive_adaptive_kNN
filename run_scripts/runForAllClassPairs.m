function [ mean_accuracy,k ] = runForAllClassPairs( A,mappedX,labels,mappedTest,test_labels,alpha_range,algorithm )


%alpha = 1.0852;
k=[];
mean_accuracy =[];
display(['algorithm=',(algorithm)]);
for alpha=alpha_range
    display(['alpha=',num2str(alpha)]);
    zNs = [];
    classpairs_Accuracy = [];
    for i=1:size(A,1)
         [X1,X2,Y1,Y2] = dataSplit(mappedX,labels,A(i,1),A(i,2));
         [testX1, testX2, testY1,testY2] = dataSplit(mappedTest,test_labels,A(i,1),A(i,2));
         test = vertcat(testX1,testX2);
         testY = vertcat(testY1,testY2);

%         [X1, X2, y1, y2] = dataSplit(mappedX, labels, A(i,1), A(i,2));
%         temp_size = size(X1, 1);
%         test_x1 = X1( 4 * temp_size /5 + 1 : temp_size, :); 
%         X1 = X1(1:4 * temp_size /5, :);
%         temp_size = size(X2, 1);
%         test_x2 = X2( 4 * temp_size/5 + 1 : temp_size, :);
%         X2 = X2(1 : 4 * temp_size /5, :);
%         temp_size = size(y1, 1);
%         test_y1 = y1(4 * temp_size/5 + 1 : temp_size, :);
%         y1 = y1(1:4 * temp_size /5, :);
%         temp_size = size(y2, 1);
%         test_y2 = y2( 4 * temp_size/5 + 1 : temp_size, :);
%         y2 = y2(1:4 * temp_size /5, :);
% 
%         test = vertcat(test_x1, test_x2);
%         testY= vertcat(test_y1, test_y2);
%         test_size = size(test_labels, 1);
        
        lambda1 = estimateRateParameter(X1,mean(X1));
        lambda2 = estimateRateParameter(X2,mean(X2));

        zN = compute_z(lambda1,lambda2,alpha,algorithm);
        zNs = vertcat(zNs,zN);
        A(i,:)
        [accuracy,K] = runAlgorithm(X1,X2,test,testY,zN,algorithm);
        classpairs_Accuracy = horzcat(classpairs_Accuracy, accuracy);
        k = horzcat(k,mean(K));
        
        
    end
    mean_accuracy = vertcat(mean_accuracy,mean(classpairs_Accuracy));
    
end

end

