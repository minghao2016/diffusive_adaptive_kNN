function decision = modMajVote( X1, X2, Xtest, N)
%   Modified majority voting for knn using theorem in paper - Diffusion 
%   Decision Making for Adaptive k-Nearest Neighbor 
%   Classification, Yung-Kyun Noh, Frank Chongwoo Park, Daniel D. Lee, 2012
sizeTest = size(Xtest,1);
decision = zeros(sizeTest,1);
for i=1:sizeTest
    
    X1_sortedDist = sortedEuclideanDistance(X1,Xtest(i,:));
    X2_sortedDist = sortedEuclideanDistance(X2,Xtest(i,:));
    X1_knearest = X1_sortedDist(N,1);
    X2_knearest = X2_sortedDist(N,1);
    
    if X1_knearest > X2_knearest
        decision(i,:) = 2;
    else
        decision(i,:) = 1;
    end
end
end