function [ prediction, N ] = conservativeDeltaVRule(X1, X2, zV, test, classes)
%   conservativeDeltaVRule Classify after an iteration of DeltaV reaching zV
%   Adaptive rule for nearest neighbour classification.
%   X1, X2 - training data for class1 and class2 respectively
%   test - test sample
%   zV - confidence level
    
    %compute distance to the two classes
    dist_X1 = sortedEuclideanDistance(X1, test);
    dist_X2 = sortedEuclideanDistance(X2, test);

    %initially take one neighbour to each class
    N = 1;
    
    while N < size(dist_X1,1) && N < size(dist_X2,1) 
        %find the difference in distance for the Nth closest point in both classes                
        d1 = dist_X1(N, 1);
        d2 = dist_X2(N, 1);
        if  dist_X1(N+1, 1) < dist_X2(N+1, 1)
            delV = abs(dist_X1(N+1, 1) - d2);
        else
            delV = abs(dist_X2(N+1, 1) - d1);
        end
        
         
        %check if evidence reached confidence level and classify
        if delV >= zV || N+1 >= size(dist_X1,1) || N+1 >= size(dist_X2,1)            
            if dist_X1(min([N, size(dist_X1,1)]), 1) < dist_X2(min([N, size(dist_X2,1)]), 1) 
                prediction = classes(1,1);
            else
                prediction = classes(2,1);
            end
            break;
        end
        
        N = N+1;
    end
    N = 2*N+1;
end

