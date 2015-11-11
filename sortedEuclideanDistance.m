function [ distances,indices ] = sortedEuclideanDistance( X, testPoint)
%sortedEuclideanDistance Sorted EuclideanDistance from a sample point to 
%                        all points in data X.
%   Take distances to all points in X, sort and return them.

t = repmat(testPoint,size(X,1),1);
euclideanDistances = sqrt(sum((t-X).^2 ,2));
[distances,indices] = sort(euclideanDistances);
end

