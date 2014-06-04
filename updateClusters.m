function [Z, dist] = updateClusters(D,c)
% Input Parameters:
% D(N,P)   data (N datapoints, P dimensions)
% c(K,P)   centroids
%
% Output Parameters:
% Z(N)     assignment of each datapoint to a class
% dist     global distortion (sum of squares)
%
% See also: kmeans, updateCentroids

N = size(D, 1);
P = size(D, 2);
K = size(c, 1);

dists = sum((repmat(D,[K 1]) - imresize(c,[K*N P],'nearest')).^2, 2);
dists = reshape(dists,N,K);

[dist, Z] = min(dists, [], 2);