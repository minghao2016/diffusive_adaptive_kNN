function predict = knnpredict( XTrain, XTest, YTrain,k )
%KNNPREDICT Predicts class of data using kNN.
%   C = knnpredict( TRAINING_DATA, TEST_DATA, TRAINING_LABELS, noOfNearestNeighbours)
%   Uses majority voting to decide on class.
%   Distance metric is Euclidean distance.

%   Initialize testResult
testSize = size(XTest,1);
predict = zeros(testSize,1);
for i=1:testSize
    %   Get thhe sorted distance between the Training and Test points
    [~,index] = sortedEuclideanDistance(XTrain,XTest(i,:));
    knearest = YTrain(index(1:k,1),1);
    predict(i,:) = mode(knearest,1);
end

end

