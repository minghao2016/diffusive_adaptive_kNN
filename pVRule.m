function [ prediction, k ] = pVRule(X1, X2, zV, test, classes)
%pNRule Classify when pN reaches zN
%   Adaptive rule for nearest neighbour classification.
%   X1, X2 - training data for class1 and class2 respectively
%   test - test sample
%   zN - confidence level
    
    %compute distance to the two classes
    dist_X1 = sortedEuclideanDistance(X1, test);
    dist_X2 = sortedEuclideanDistance(X2, test);

    %initially take one neighbour to each class
    N = 1;
    k = 2*N;
    D = 9; %9-D subspace
    gamma_constant = (pi ^ (D/2))/gamma(D/2 +1); 
    
    while  N<=size(dist_X1,1) || N<=size(dist_X2,1) 
        
        u1 = N * (gamma_constant * dist_X1(N,1)^D);
        u2 = N * (gamma_constant * dist_X2(N,1)^D);
        
        %measuring total no. of neighbors
        k = 2*N;
        [pv12] = compute_PV(N,u1,u2);
        pv21 = 1- pv12;

        %check if evidence reached confidence level and classify
        if max(pv12,pv21) >= zV || N>size(dist_X1,1) || N>size(dist_X2,1)            
            if pv12 > pv21
                prediction = classes(1,1);
            else
                prediction = classes(2,1);
            end
            break;
        end
        
        N= N+1;
    end
    
end

