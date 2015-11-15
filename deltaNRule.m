function [ prediction ] = deltaNRule(X1, X2, zN, test)
%deltaNRule Stops and classifies when DeltaN reaches zN
%   Diffusion Decision Making for Adaptive k-Nearest Neighbor 
%   Classification, Yung-Kyun Noh, Frank Chongwoo Park, Daniel D. Lee, 2012
    
    dist_X1 = sortedEuclideanDistance(X1, test);
    dist_X2 = sortedEuclideanDistance(X2, test);

    N1 = 1;
    N2 = 1;
    while true
        if(dist_X1(N1, 1) > dist_X2(N2, 1))
            N2 = N2+1;
        else
            N1 = N1+1;
        end
        k = N1+N2;
        delN = abs(N1-N2);
                    
        if delN >= zN || N1>size(dist_X1,1) || N2>size(dist_X2,1)            
            if N1 > N2
                prediction = 1;
            else
                prediction = 2;
            end
            break;
        end
    end
end

