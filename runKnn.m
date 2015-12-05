knn_mean_accuracy =[];
for k_k = 3:4:25
    display(num2str(k_k));
    knn_Accuracy = [];
    for i=1:size(A,1)
        [X1,X2,Y1,Y2] = dataSplit(mappedX,labels,A(i,1),A(i,2));
        [testX1, testX2, testY1,testY2] = dataSplit(mappedTest,test_labels,A(i,1),A(i,2));
        test = vertcat(testX1,testX2);
        testY = vertcat(testY1,testY2);
        X= vertcat(X1,X2);
        Y= vertcat(Y1,Y2);
        test_size = size(test,1);
        prediction  = zeros(test_size,1);
        mdl = fitcknn(X,Y,'NumNeighbors',k_k);
        success=0;
        for i=1:test_size
            prediction(i) = predict(mdl,test(i,:));
            
            if testY(i, 1) == prediction(i, 1)
                success = success + 1;
            end
        end
        accuracy = success*100/test_size;
        knn_Accuracy = horzcat(knn_Accuracy, accuracy);
    end
    knn_mean_accuracy = vertcat(knn_mean_accuracy,mean(knn_Accuracy));
    
end
