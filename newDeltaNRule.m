function [ prediction, k ] = newDeltaNRule(X1, X2, zN, test, classes)
%newDeltaNRule Classify when DeltaN reaches zN
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
    
    %volume growth metric
    del = 0.1;
    
    %growing the hypersphere of inclusion
    d = min(min(dist_X1),min(dist_X2));
    
    while d <= max(max(dist_X1),max(dist_X2))
        %find the nearer neighbor and include more of nearer class
        N1 = sum(dist_X1(:)<=d);
        N2 = sum(dist_X2(:)<=d);
        
        %measuring total no. of neighbors
        k = N1+N2;
        
        delN = abs(N1-N2);
        
        %check if evidence reached confidence level and classify
        if delN >= zN || N1>size(dist_X1,1) || N2>size(dist_X2,1)
            break;
        end
        d = d + del;
    end
    if N1 ==0
        prediction = classes(2,1);
        return;
    elseif N2 == 0
        prediction = classes(1,1);
        return;
    end    
    if dist_X1(N1,1) < dist_X2(N2,1)
        prediction = classes(1,1);
    else
        prediction = classes(2,1);
    end
    zN
end