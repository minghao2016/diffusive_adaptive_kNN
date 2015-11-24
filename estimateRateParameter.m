function [ lambda ] = estimateRateParameter( X, t)
%estimateRateParameter Estimates the rate parameter of appearance of
%nearest neighbors of one class data.


lambda = 0;
poisson_N = [];
N =0;
DN = 0;
dist = sortedEuclideanDistance(X,t);
for d=1:0.1:max(dist)
    tempN = N;
    N = sum(dist(:)<d);
    DN = N-tempN;
    poisson_N = vertcat(poisson_N,DN);
end
lambda = mean(poisson_N);
end

