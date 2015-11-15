function [ distances,indices ] = sortedEuclideanDistance( X, testPoint)
%sortedEuclideanDistance Sorted EuclideanDistance from a sample point to 
%                        all points in data X.
%   Take distances to all points in X, sort and return them.
%   repeats the testpoint vector, vertically as many times as the number of 
%   points in X and only once horizontally.
repated_test_point = repmat(testPoint, size(X, 1), 1); 
euclideanDistances = sqrt(sum((repated_test_point - X).^2, 2));
[distances, indices] = sort(euclideanDistances);
end

