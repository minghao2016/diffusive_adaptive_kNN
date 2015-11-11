function [ prediction ] = deltaNRule( X1,X2,zN,test)
%deltaNRule Stops and classifies when DeltaN reaches zN
%   Diffusion Decision Making for Adaptive k-Nearest Neighbor 
%   Classification, Yung-Kyun Noh, Frank Chongwoo Park, Daniel D. Lee, 2012
dist_X1 = sortedEuclideanDistance(X1,test);
dist_X2 = sortedEuclideanDistance(X2,test);

%currently fix distance as the 5th farthest of the two classes
d = max(dist_X1(5,1),dist_X2(5,1));

while true
    N1 = sum(dist_X1<d);
    N2 = sum(dist_X2<d);
    k = N1+N2;
    delN = abs(N1-N2);
    if delN >= zN || k>size(dist_X1,1) || k>size(dist_X2,1)
        dist_N1 = dist_X1(N1,1);
        dist_N2 = dist_X2(N2,1);
        if dist_N1 < dist_N2
            prediction = 1;
        else
            prediction = 2;
        end
        break;
    end
    d = max(dist_X1(k,1),dist_X2(k,1));
end

end

