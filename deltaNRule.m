function [ prediction, k ] = deltaNRule(X1, X2, zN, test, classes)
%deltaNRule Classify when DeltaN reaches zN
%   Adaptive rule for nearest neighbour classification.
%   X1, X2 - training data for class1 and class2 respectively
%   test - test sample
%   zN - confidence level
    
    %compute distance to the two classes
    dist_X1 = sortedEuclideanDistance(X1, test);
    dist_X2 = sortedEuclideanDistance(X2, test);

    %initially take one neighbour to each class
    N1 = 1;
    N2 = 1;
    
   
    while true
        %find the nearer neighbor and include more of nearer class
        if(dist_X1(N1, 1) > dist_X2(N2, 1))
            N2 = N2+1;
        else
            N1 = N1+1;
        end
        
        %measuring total no. of neighbors
        k = N1+N2;
        
        delN = abs(N1-N2);
        
        %check if evidence reached confidence level and classify
        if delN >= zN || N1>size(dist_X1,1) || N2>size(dist_X2,1)            
            if N1 > N2
                prediction = classes(1,1);
            else
                prediction = classes(2,1);
            end
            break;
        end
    end
end

