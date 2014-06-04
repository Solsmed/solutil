function newc = updateCentroids(D,Z,K)
% Input Parameters:
% D(N,P)  data (N datapoints, P dimensions)
% Z(N)     assignment of each datapoint to a class
% K        number of centroids (classes)
%
% Output Parameters:
% newc(K,P) new centroids
%
% See also: kmeans, updateClusters

newc = nan(K,size(D,2));
for v=1:K
    newc(v,:) = mean(D(Z == v, :));
end