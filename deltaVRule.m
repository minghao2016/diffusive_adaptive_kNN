function [ prediction, N ] = deltaVRule(X1, X2, zV, test, classes)
%deltaVRule Classify when delta-V reaches zV
%   Adaptive rule for nearest neighbour classification.
%   X1, X2 - training data for class1 and class2 respectively
%   test - test sample
%   zV - confidence level
    
    %compute distance to the two classes
    dist_X1 = sortedEuclideanDistance(X1, test);
    dist_X2 = sortedEuclideanDistance(X2, test);

    %initially take one neighbour to each class
    N = 1;
    
    while true
        %find the difference in distance for the Nth closest point in both classes                
        delV = abs(dist_X1(N, 1) - dist_X2(N, 1));
        %check if evidence reached confidence level and classify
        if delV >= zV || N >= size(dist_X1,1) || N >= size(dist_X2,1)            
            if dist_X1(N, 1) < dist_X2(N, 1)
                prediction = classes(1,1);
            else
                prediction = classes(2,1);
            end
            break;
        end
        
        N = N+1;
    end
end

